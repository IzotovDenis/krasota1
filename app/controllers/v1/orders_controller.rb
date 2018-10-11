class V1::OrdersController <  V1Controller
    before_action :set_order, :only => [:show, :set_formed, :pay]
    before_action :set_active, only: [:getActive]
    before_action :prepare_order, only: [:getOrderItems, :create]

    def index
        render json: { orders: current_user.orders.formed }
    end

    def show
        if @order
            render json: @order
        else
            render json: { err: 'not found' }
        end
    end

    def create
        @order.user = current_user
        if @order.set_formed
            render json: {order: @order, success: true}
        else
            render json: {success: false, errors: @order.errors}
        end
    end

    def getOrderItems
        render :json => {user: @order.user, items: @order.avaiable_items, not_able: @order.unavaiable_items, amount: @order.pre_amount, valid: @order.is_valid? }
    end

    def changeCount
        @items = Item.where("id IN (?)", params[:items])
        able = {}
        @items.each do |item|
            able[item.id] = item.in_stock
        end
        render :json => {items: @items, able: able}
    end

    def pay
        if @order.pay
            response = @order.pay
            render :json => {success: true, response: response }
        else
            render :json => {success: false, errors: @order.errors}
        end
    end

    private

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

    def prepare_order
        @order = Order.new(:order_list=>params[:items], :info=>params[:info], :comment=>params[:comment], :rate=>current_rate)
    end
    
end