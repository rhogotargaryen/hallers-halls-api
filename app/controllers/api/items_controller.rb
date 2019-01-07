class Api::ItemsController < ApplicationController
    before_action :authenticate_user!, except: [:show]

    def create
        item = Item.create(item_params)
        item.user = current_user
        if item.save 
            return render_resource(item)
        else
            return render json: {
                errors: [
                  {
                    status: '400',
                    title: 'Bad Request',
                    detail: "Something went wrong on the backend, changes not saved",
                    code: '100'
                  }
                ]
              }, status: :bad_request
        end
    end

    def update
        a = Item.find_by(id: params[:id])
        if current_user === a.user && a.update!(item_params)
            return render json: a
        else
            return render json: {
                errors: [
                  {
                    status: '400',
                    title: 'Bad Request',
                    detail: "Something went wrong on the backend, changes not saved",
                    code: '100'
                  }
                ]
              }, status: :bad_request
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