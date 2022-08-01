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

        desc 'Update a user'
        route_param :id, type: Integer do
          params do
            requires :first_name, type: String
            requires :last_name, type: String
            requires :email, type: String
          end

          post :update do
            user = User.find(params[:id])
            if user && user == current_user
              user.first_name = params[:first_name]
              user.last_name = params[:last_name]
              user.email = params[:email]
              if user.save!
                status = :success
              else
                status = :failed
              end
            else
              status = :failed
            end
            if status == :success
              {
                operation_status: status,
                baseline: user.to_json
              }
            else
              {
                operation_status: status,
              }
            end
          end

        end


      end
    end
  end
end
