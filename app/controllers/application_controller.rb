class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :no_session

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end

  def validation_error_with_msg(resource)
    render json: {
      errors: resource.errors.full_messages},
      status: :bad_request
  end

  def def_validation_error()
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: "Not Authorized",
          code: '100'
        }
      ]
    }, status: :bad_request
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def no_session
    request.session_options[:skip] = true
  end

end
