require 'doorkeeper/grape/helpers'

module Api
  module V1
    class Base < Grape::API
      prefix "api"
      version "v1", using: :path
      format :json
      content_type :json, 'application/json'

      helpers Doorkeeper::Grape::Helpers

      before do
        doorkeeper_authorize!
      end

      mount Api::V1::Users
    end
  end
end
