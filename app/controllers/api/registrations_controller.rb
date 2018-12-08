class Api::RegistrationsController < Devise::RegistrationsController
    respond_to :json
  
    def create
      debugger
      build_resource(sign_up_params)
  
      resource.save
      render_resource(resource)
    end

end