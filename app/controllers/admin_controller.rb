class AdminController < ApplicationController
    before_action :authorize
    rescue_from CanCan::AccessDenied do |exception|
        render json: {success: false, error: exception}, status: 400
    end

    def authorize
        raise CanCan::AccessDenied unless current_user && current_user.role == 'admin'
    end
end