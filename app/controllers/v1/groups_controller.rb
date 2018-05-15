class V1::GroupsController <  V1Controller
    before_action :set_group, only: [:show]

    def index
        
        @groups = Group.select("title, id, FALSE as has_children, FALSE as opened").all.index_by(&:id)
        @sort = Group.select("ancestry, id, title, FALSE as opened").arrange_serializable(:order=>:title) do |parent, children|
            h = {id: parent.id, title: parent.title}
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
        @items = @group.items
        render json: {group: @group, items: @items}
    end

    def set_group
        @group = Group.find(params[:id])
    end

end