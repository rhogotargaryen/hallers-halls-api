class Api::UsersController < ApplicationController
    before_action :authenticate_user!, except: [:create]

    def index
        users = User.all
        render json: users
    end

    def show
        user = User.find_by(id: params[:id])
        render json: user
    end

    def update
        user = User.find(params[:id])
        if current_user === user
			byebug
			user.avatar.attach(user_params[:avatar])
			puts user.avatar.attached?
            if user.update(name: user_params[:name], email: user_params[:email])
                return render json: user
            else
                return validation_error_with_msg(user)
            end
        else
            return def_validation_error()
        end
    end

    def delete
        user = User.find(params[:id])
        if current_user === user
            user.destroy
            return render json: {message: "The user has been deleted permantely"}
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :avatar => {})
    end
end
