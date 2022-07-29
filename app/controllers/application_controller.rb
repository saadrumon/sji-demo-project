class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters

    devise_parameter_sanitizer
      .permit(:sign_in) do |u|
      u.permit(
        :email,
        :password,
        :remember_me
      )
    end

    devise_parameter_sanitizer
      .permit(:account_update) do |u|
      u.permit(
        :first_name,
        :last_name,
        :payment_method,
        :email,
        :password,
        :password_confirmation
      )
    end
  end
end
