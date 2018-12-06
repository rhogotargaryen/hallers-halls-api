class SessionsController < ApplicationController

    def create
        if auth
          @user = User.find_or_create_by_oauth(auth)
          session[:user_id] = @user.id
          puts("user created/found through FB")
          render json: @user
        else @user = User.find_by(name: params[:user][:name])
          if @user.authenticate!(params[:user][:password])
            session[:user_id] = @user.id
            render json: @user
          else
            #return errors
            puts("was not able to validate, please check log in and try again")
          end
      end
    end

    def destroy
        reset_session
        puts('logged out')
        redirect_to '/'
    end

    private
    
    def auth
        request.env['omniauth.auth']
    end

end

