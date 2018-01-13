class RegistrationsController < DeviseTokenAuth::RegistrationsController

  include Recaptcha::Verify

  def create
    verify_recaptcha!
    super
  end

end
