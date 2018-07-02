class V1::OrdersController <  V1Controller
    before_action :set_order, :only => [:show, :set_formed]
    before_action :set_sync_order, :only => [:sync]
    before_action :set_new_order, :only => [:create]
    before_action :set_active, only: [:getActive]

    def index
        render json: { orders: current_user.orders }
    end

    def show
        if @order
            render json: { order: @order}
        else
            render json: { err: 'not found' }
        end
    end

    def sync
        orderItems = {}
        orderItemsParams = params[:orderList]
        orderItemsParams.keys.each do |itemId|
            orderItems[itemId.to_i] = orderItemsParams[itemId].to_i
        end
        @order.items = orderItems
        @order.save
        render json: {order: @order.as_json}
    end

    def create
        if @order.save
            render json: {success: true, order: @order}
        else
            render json: {success: false, errors: @errors}
        end
    end

    def set_formed
        if @order.set_formed
            render json: {success: true}
        else
            render json: {success: false, errors: @order.errors}
        end
    end

    def getActive
        
    end

    def getOrderItems
        @items = Item.where("id IN (?)", params[:items])
        render :json => {items: @items}
    end

    private

    def set_sync_order
        if params[:id]
            @order = Order.find(params[:id])  
        else
            @order = Order.create(user_id:5)
        end
    end

    def set_order
        @order = Order.find(params[:id])
    end

    def getActive
        @active_order = Order.where(:user_id=> current_user)
    end

    def order_items
        keys = order_list.keys
        Item.where("id IN (?)", keys)
    end

    def order_list
        params[:order][:items]
    end

    def set_new_order
        @user = User.first
        @order = Order.new(user_id: @user.id)
        order_items.each do |item|
            count = order_list[item.id.to_s]
            @order.items[item.id] = {id: item.id, qty: count, uid: item.uid }
            @order.amount += item.price*count
            @order.items_count +=1
        end
    end
    
end