class V1::UsersController <  V1Controller
    before_action :isAuth, :only => [:update_fields]

    def profile
        render json: {message: "profile"}
    end

    def init_user
        if current_user
            render json: {success: true, profile: current_user.slice(:email, :tel, :name, :role, :city, :comment)}
        else
            render json: {success: false}
        end
    end

    def get_pin
        render json: {message: "profile"}
    end

    def update_fields
        if current_user.update(update_user_params)
            render json: {success: true}
        else
            render json: {success: false, errors: current_user.errors}
        end
    end

    def send_pin
        user = User.where(:tel=>params[:tel]).first_or_create do |user|
            user.tel = params[:tel]
            user.password = '2212345678'
            user.password_confirmation = '2212345678'
        end
        if user.send_pin
            render json: {success: true}
        else
            render json: {success: false}
        end
    end

    def check_pin
        tel = params[:tel].gsub(/[^\d]/, '')
        pin = params[:pin].gsub(/[^\d]/, '')
        @user = User.where(:tel=>tel,:pin=>pin).select("id, name, tel").first
        if @user
            token = AuthCommands.generate_token(@user.id)
            render json: {success: true, user: @user, token: token.val}
        else
            render json: {success: false}
        end
    end

    private

    def update_user_params
        params.require(:user).permit(:name, :city, :email, :comment)
    end

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def isAuth
        if !current_user 
            render json: {success: false, error: 'not auth'}
        end
    end
    
end