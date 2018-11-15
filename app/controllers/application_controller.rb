class ApplicationController < ActionController::API

    rescue_from CanCan::AccessDenied do |exception|
        render json: {success: false, error: exception}, status: 400
    end

    def current_user
        @current_user ||= AuthCommands.current_user(params[:token])
    end

    def current_rate
        @current_rate = current_user ? (100.00-current_user.discount)/100 : 1  
    end

end
