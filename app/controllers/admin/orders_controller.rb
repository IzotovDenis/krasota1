class Admin::OrdersController < AdminController
    before_action :set_order, only: [:set_received, :show, :update]

    def index
        if params[:created_at_more]
            time = DateTime.strptime(params[:created_at_more], '%Y%m%d%H%M%S').change(:offset=>"+1000")
            @orders = @orders.where('created_at > ?', time)
        end
        if params[:paid_at_more]
            time = DateTime.strptime(params[:paid_at_more], '%Y%m%d%H%M%S').change(:offset=>"+1000")
            @orders = @orders.where('paid_at > ?', time)
        end
        @orders = Order.where(query_params).map do |order|
            order.for_1c
        end
        render json: {orders: @orders}
    end

    def update
        if @order.update(order_params)
            render json: {success: true, order: @order.for_1c}
        else
            render json: {success:false, errors: @order.errors}
        end
    end


    def create_rand
        items = Item.where("price > ?", 12).limit(10).order("RANDOM()")
        order_list = {}
        @order = Order.new(user: User.first)
        items.each do |item|
            order_list[item.id] = {id: item.id, qty: rand(10), uid: item.uid, price: item.price}
        end
        @order.items = order_list
        @order.save
        @order.set_formed
        render json: {order: @order.as_json}
    end

    def show
        render json: {order: @order.for_1c}
    end


    private

    def query_params
        params.permit(:payable, :received, :formed, :is_paid, :formed_at, :received_at, :user_id,)
    end

    def set_order
        @order = Order.find(params[:id])
    end

    def order_params
        params.require(:order).permit(:received, :is_paid, :payable)
    end

end
