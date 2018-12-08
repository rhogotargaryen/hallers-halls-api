class Api::SessionsController < ApplicationController
  respond_to :json

    def create
      debugger
      render json: (test: "ing")
    end

    def destroy
      reset_session
      render json: {status: "logged out"}
    end
    
    private
    
    def respond_with(resource, _opts = {})
      render json: resource
    end

    def respond_to_on_destroy
      head :no_content
    end
end

