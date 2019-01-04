
class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)
    resource.save
    if !resource.errors.messages.empty?
      return validation_error_with_msg(resource)
    else
      sign_in(resource_name, resource)
    end
  end
end