class Api::ItemsController < ApplicationController


    def create
        item = Item.create!(item_params)
        if item.error?
            render json: item.error
        else
            render json: item
        end
    end

    def update
        a = Item.find_by(id: params[:id])
        debugger
        if Item.find_by(id: params[:id])
            Item.update(item_params)
            render json: item
        else
            render json: {error: "item not found"}
        end
    end
    
    def show
    end

    def index
        items = Item.all
        render json: items
    end
    
end