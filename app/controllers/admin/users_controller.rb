class Admin::UsersController < AdminController
    rescue_from ActiveRecord::RecordNotFound do |exception|
        render json: {success: false, error:'user not fount'}, :status => 404 # nothing, redirect or a template
    end

    before_action :set_user, only: [:show, :update]

    def index
        @users = User.all.map do |user|
            user.for_1c
        end
        render json: {users: @users}
    end

    def show
        if @user
            render json: {user: @user.for_1c}
        else
            render json: {user: null}
        end
    end

    def update
        if @user.update(user_params)
            render json: {user: @user.for_1c}
        else
            render json: {user: null, errors: @user.errors}
        end
    end

    def create
        @user = User.new(user_params)
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.created_from_1c = true
        if @user.save
            render json: {success: true, user: @user.for_1c}
        else
            render json: {success: false, errors: @user.errors}, status: 422
        end
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :tel, :email, :firstname, :lastname, :thirdname, :discount, :zip_code, :address, :city)
    end

    def auto_password
        @auto_password = rand(99999999)
    end

end
