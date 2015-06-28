module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      resource :users do
        route_param :id do
          resource :transactions do
            desc 'Retrieves all transactions for the specified user'
            params do
              optional :other_user, type: Integer, desc: 'The id of the user' \
                'in the group'
            end
            get do
              # stub
            end
          end
        end
      end
    end
  end
end
