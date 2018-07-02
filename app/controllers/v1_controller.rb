class V1Controller < ApplicationController

    def current_user
        @current_user ||= AuthCommands.current_user(params[:token])
    end

end
  