class Api::ItemsController < ApplicationController
    before_action :auth_req, except[:show, :index]

    def create
        item = Item.create!(item_params)
        render json: item
    end

    def update
        a = Item.find_by(id: params[:id])
        if Item.find_by(id: params[:id])
            Item.update(item_params)
            render json: item
        else
            render json: {error: "item not found"}
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

    private

    def item_params
       params.require(:item).permit(:name, :user_id, :description, :price, :img_url)
    end
    
end