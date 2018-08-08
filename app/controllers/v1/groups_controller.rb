class V1::GroupsController <  V1Controller
    before_action :set_group, only: [:show]

    def index
        @groups = Group.select("title, id, FALSE as has_children").all.index_by(&:id)
        @sort = Group.select("ancestry, id, title, items_count, columns_count").arrange_serializable(:order=>:title) do |parent, children|
            h = {id: parent.id, title: parent.title, items_count: parent.items_count, columns_count: parent.columns_count}
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
        @items = @group.items.
        joins("LEFT OUTER JOIN likes ON (likes.item_id = items.id AND likes.user_id = #{current_user ? current_user.id : 0})").
        select("
        items.title,
        items.price,
        items.image,
        items.uid,
        items.likes_counter, 
        CASE coalesce(likes.id, 0) WHEN 0 THEN 'false'::boolean ELSE 'true' END AS user_like, 
        items.id").paginate(:page => currentPage)
        render json: {group: @group, items: @items, pageLoaded: currentPage.to_i}
    end

    

    def set_group
        @group = Group.find(params[:id])
    end

end