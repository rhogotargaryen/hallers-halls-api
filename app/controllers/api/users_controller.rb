class Api::UsersController < ApplicationController
    before_action :authenticate_user!, except: [:create]

    def create
    end

    def index
        users = User.all
        puts("return user objects")
        render json: users
    end

    def show
        render json: current_user
    end

    def update
        user = User.find(user_params[:id])
        user.update(user_params)
        render json: user
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password)
    end

end
