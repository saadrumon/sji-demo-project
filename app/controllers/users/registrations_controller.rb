class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: %i[update]
  
  protected

  def sign_up_params
    params.require(:user).permit(
        :first_name,
        :last_name,
        :payment_method,
        :email,
        :password,
        :password_confirmation
    )
  end
end
