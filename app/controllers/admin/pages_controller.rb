class Admin::PagesController < AdminController
    rescue_from ActiveRecord::RecordNotFound do |exception|
        render json: {success: false, error:'page not fount'}, :status => 404 # nothing, redirect or a template
    end

    before_action :set_page, only: [:show, :update]

    def index
        @pages = Page.all
        render json: {pages: @pages}
    end

    def show
        if @page
            render json: {page: @page}
        else
            render json: {page: null}
        end
    end

    def update
        if @page.update(page_params)
            render json: {success: true, page: @page}
        else
            render json: {success: false, page: null, errors: @page.errors}
        end
    end

    def destroy
        if @page.destroy
            render json: {success: true}
        else
            render json: {success: false}
        end
    end

    def create
        @page = Page.new(page_params)
        if @page.save
            render json: {success: true, page: @page}
        else
            render json: {success: false, errors: @page.errors}
        end
    end

    private

    def set_page
        @page = Page.find(params[:id])
    end

    def page_params
        params.require(:page).permit(:title, :link, :content, :html)
    end

end
