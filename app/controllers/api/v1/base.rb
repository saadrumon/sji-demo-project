module API
  module V1
    class Base < Grape::API
      prefix "api"
      version "v1", using: :path
      format :json

      mount API::V1::Users
    end
  end
end
