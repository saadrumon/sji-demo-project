module Api
  module V1
    class Users < Grape::API
      include Api::V1::Defaults
      
      resource :users do

        desc 'Return all users'
        get do
          User.all
        end

        desc 'Return a specific users'
        route_param :id, type: Integer do
          get do
            User.find(params[:id])
          rescue ActiveRecord::RecordNotFound
            error!('User not found!', 404)
          end
        end

      end
    end
  end
end
