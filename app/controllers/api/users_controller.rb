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
            user.update(user_params)
            return render json: user
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
        params.require(:user).permit(:name, :email, :password)
    end
end
