class V1::ItemsController < V1Controller
    before_action :set_item, only: [:show]

    def index
        render json: {msg: "this works"}
    end

    def show
        render json: {item: @item}
    end

    def rand
        @items = Item.order("RANDOM()").limit(12)
        render json: @items
    end

    def set_item
        @item = Item.find(params[:id])
    end
end