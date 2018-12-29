class Api::ItemsController < ApplicationController
    before_action :authenticate_user!, except: [:show]

    def create
        item = Item.create!(item_params)
        render json: item
    end

    def update
        a = Item.find_by(id: params[:id])
        if current_user === a.user
            Item.update(item_params)
            render json: item
        else
            return def_valiadtion_error()
        end
    end
    
    def show
        item = Item.find_by(id: params[:id])
        render json: item
    end

    def index
        items = Item.all
        render json: items
    end

    def delete
        a = Item.find_by(id: params[:id])
        if current_user === a.user
            a.destroy
            render json: {message: "The itemhas been deleted permantely"}
        else
            return def_valiadtion_error()
        end
    end

    private

    def item_params
       params.require(:item).permit(:name, :user_id, :description, :price, :img_url)
    end
    
end