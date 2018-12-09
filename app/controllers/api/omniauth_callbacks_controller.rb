class Api::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      a = request.env["omniauth.auth"]
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      user = User.from_omniauth(request.env["omniauth.auth"])

      if user.persisted?
        render_resource(user)
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to api_user_session_url
      end
    end
  
    def failure
      render json: {error: "Facebook could not auth"}
    end
  end
