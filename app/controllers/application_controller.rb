class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :policy_fail

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def policy_fail(exception)
    render json: {}, :status => :unauthorized
  end

  def configure_permitted_parameters
    added_attrs = [:nickname]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    #devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

end
