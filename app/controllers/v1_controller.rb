class V1Controller < ApplicationController

    def current_user
        @current_user ||= AuthCommands.current_user(params[:token])
    end

    def current_rate
        @current_rate = current_user ? (100.00-current_user.discount)/100 : 1  
    end

end
  