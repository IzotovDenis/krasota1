class Admin::OrdersController < AdminController
    before_action :set_order, only: [:set_received, :show]

    def index
        @orders = Order.for_admin.formed
        render json: {orders: @orders.as_json}
    end

    def not_received
        @orders = Order.for_admin.formed.not_received
        render json: {orders: @orders.as_json}
    end

    def set_received
        if @order.set_received
            render json: {success: true}
        else
            render json: {success: false, errors: @order.errors}
        end
    end

    def set_confirmed
        if @order.set_confirmed
            render json: {success: true, order: @order.as_json}
        else
            render json: {success: false, errors: @order.errors}
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
        render json: {order: {
            id: @order.id,
            items: @order.for_1c,
            amount: @order.amount,
            formed: @order.formed,
            info: @order.info,
            user: @order.user.slice(:id, :name, :tel, :email),
            formed_at: (@order.formed_at ? @order.formed_at.to_i : nil),
            received: @order.received,
            received_at: (@order.received_at ? @order.received_at.to_i : nil),
            items_count: @order.items_count,
            created_at: @order.created_at.to_i
        }}
    end

    private

    def set_order
        @order = Order.find(params[:id])
    end

end
