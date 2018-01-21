class RegistrationsController < DeviseTokenAuth::RegistrationsController

  include Recaptcha::Verify

  def create

    ActiveRecord::Base.transaction do
      u = User.new sign_up_params
      if !u.valid?
        return render json: { errors: u.errors.full_messages }, status: :unprocessable_entity
      end

      verify_recaptcha!
      super

    end
  end

end
