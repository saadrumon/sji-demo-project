module Api
  module V1
    module Auth
      class RegistrationsController < ApplicationController
        respond_to :json
        skip_before_action :verify_authenticity_token
        
        include DoorkeeperRegisterable

        def register
          client_app = Doorkeeper::Application.find_by(uid: user_params[:client_id])
          
          unless client_app
            return render json: { error: I18n.t('doorkeeper.errors.messages.invalid_client') },
                          status: :unauthorized
          end

          allowed_params = user_params.except(:client_id)
          user = User.new(allowed_params)

          if user.save
            render json: render_user(user, client_app), status: :ok
          else
            render json: { errors: user.errors }, status: :unprocessable_entity
          end
        end

        private

        def user_params
          params.permit(
            :first_name,
            :last_name,
            :payment_method,
            :email,
            :password,
            :password_confirmation,
            :client_id
          )
        end
      end
    end
  end
end
