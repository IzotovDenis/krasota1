class V1::UsersController <  V1Controller

    def profile
        render json: {message: "profile"}
    end

    def sign_in
        render json: {message: "profile"}
    end

    def sign_up
        @user = User.new(user_params)
        if @user.save
            command = AuthenticateUser.call(params[:user][:email], params[:user][:password])
            render json: { auth_token: command.result }
        else
            render json: {errors: @user.errors}
        end
    end

    def sign_in 
        command = AuthenticateUser.call(params[:email], params[:password]) 
        if command.success? 
            render json: { auth_token: command.result } 
        else 
            render json: { error: command.errors }, status: :unauthorized 
        end 
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
    
end