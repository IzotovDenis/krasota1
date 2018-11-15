class V1::PagesController < V1Controller
    before_action :set_page, only: [:show]

    def show
        if @page 
            render json: {page: @page}
        else
            render json: {page: {}}, status: 404
        end
    end

    def set_page
        @page = Page.where(:link => params[:pageLink]).first
    end
end