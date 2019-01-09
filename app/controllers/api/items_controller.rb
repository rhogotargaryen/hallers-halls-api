class Api::ItemsController < ApplicationController
    before_action :authenticate_user!, except: [:show]

    def create
        item = Item.create(item_params)
        item.user = current_user
        if item.save
            return render_resource(item)
        else
            errors = {errors: item.errors.full_messages}
            return render json: errors
        end
    end

    def update
        a = Item.find_by(id: params[:id])
        if current_user === a.user && a.update(item_params)
            return render json: a
        else
            errors = {errors: a.errors.full_messages}
            return render json: errors
        end
    end
    
    def show
        item = Item.find_by(id: params[:id])
        render json: item
    end

    def index
        if !!params[:user_id]
            items = Item.find_by(user_id: params[:user_id])
        else
            items = Item.all
        end
        render json: items
    end

    def delete
        a = Item.find_by(id: params[:id])
        if current_user === a.user
            a.destroy
            render json: {message: "The item has been deleted permantely"}
        else
            return def_valiadtion_error()
        end
    end

    private

    def item_params
       params.require(:item).permit(:name, :user_id, :description, :price, :img_url)
    end
    
end