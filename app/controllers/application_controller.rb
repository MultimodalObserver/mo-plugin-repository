class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :policy_fail

  protected
  def policy_fail(exception)
    render json: {}, :status => :unauthorized
  end
end
