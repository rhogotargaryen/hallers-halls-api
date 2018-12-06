class ApplicationController < ActionController::API
    def auth_req
        if !logged_in?
          render json: {error: "must be logged"}
        end
    end
    
    def logged_in?
      !!@current_user
    end
  
    def current_user
      @current_user || User.find_by(id: session[:user_id]) if session[:ser_id]
    end
    
end
