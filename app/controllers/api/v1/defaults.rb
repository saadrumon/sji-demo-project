module Api
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        helpers do
          def current_user
            @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
          end
        end
      end
    end
  end
end
