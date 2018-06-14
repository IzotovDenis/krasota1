class V1::UsersController <  V1Controller

    def profile
        render json: {message: "profile"}
    end

    def sign_in
        render json: {message: "profile"}
    end

    def send_pin
        user = User.where(:tel=>params[:tel]).first_or_create do |user|
            user.tel = params[:tel]
        end
        if user.send_pin
            render json: {success: true}
        else
            render json: {success: false}
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
    
end