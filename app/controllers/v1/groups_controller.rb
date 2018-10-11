class V1::GroupsController <  V1Controller
    before_action :set_group, only: [:show]

    def index
        @groups = Group.where(:disabled=>false).select("title, id, FALSE as has_children").all.index_by(&:id)
        @sort = Group.where(:disabled=>false).select("ancestry, id, title, items_count, columns_count, sort").arrange_serializable(:order=>:title) do |parent, children|
            h = {id: parent.id, title: parent.title, items_count: parent.items_count, columns_count: parent.columns_count, sort: parent.sort}
            h[:children] = children
            h[:has_children] = false
            if children.length > 0
                h[:has_children] = true
            end
            h
        end        
        render json: {list:@groups, tree:@sort}
    end

    def show
        currentPage = params[:page] || 1
        @items = @group.items.with_stock.with_discount(current_rate).paginate(:page => currentPage)
        render json: {group: @group, items: @items, pageLoaded: currentPage.to_i}
    end

    

    def set_group
        @group = Group.find(params[:id])
    end

end