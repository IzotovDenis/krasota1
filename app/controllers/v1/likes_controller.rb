class V1::LikesController < V1Controller

    def index
        items = current_user.likes.joins(:item).select("items.title,
        items.price,
        items.image,
        items.uid,
        items.likes_counter,
        'true' as user_like")
        render json: {items: items}
    end

    def set_like
        item_id = params[:item_id].to_i
        like = Like.where(:item_id=> item_id, :user=>current_user).first_or_initialize
        if like.save
            render json: {success: true}
        else
            render json: {success: false, errors: like.errors, user: current_user}
        end
    end

    def del_like
        item_id = params[:item_id].to_i
        like = Like.where(:item_id=> item_id, :user=>current_user).first
        if like
            if like.destroy
                render json: {success: true}
            else
                render json: {success: false}
            end
        else
            render json: {success: false}
        end
    end


end