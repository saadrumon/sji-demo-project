class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: :json_request?
  before_action :authenticate_user!, unless: :json_request?
  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :verify_authenticity_token, if: :json_request?

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
      .permit(:sign_up) do |u|
      u.permit(
        :first_name,
        :last_name,
        :payment_method,
        :email,
        :password,
        :password_confirmation
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
        :password_confirmation,
        :current_password
      )
    end
  end

  private

  def json_request?
    request.format.json?
  end
end
