class Admin::UsersController < AdminController
    rescue_from ActiveRecord::RecordNotFound do |exception|
        render json: {success: false, error:'user not fount'}, :status => 404 # nothing, redirect or a template
    end

    before_action :set_user, only: [:show]

    def index
        @users = User.select(:id, :name, :email, :created_from_1c, :tel)
        render json: {users: @users}
    end

    def show
        if @user
            render json: {user: @user}
        else
            render json: {user: null}
        end
    end

    def create
        @user = User.new(user_params)
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.created_from_1c = true
        if @user.save
            render json: {success: true, user: @user.slice(:id, :email, :name, :tel, :created_from_1c)}
        else
            render json: {success: false, errors: @user.errors}
        end
    end

    private

    def set_user
        @user = User.select(:id, :tel, :email, :name).find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :tel, :email)
    end

    def auto_password
        @auto_password = rand(99999999)
    end

end
