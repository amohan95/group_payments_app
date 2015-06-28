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
              if (defined? params[:other_user]) 
                other_user = params[:other_user]
                current_user.user_transactions.find_by(other_user: other_user) +
                  current_user.other_user_transactions.find_by(user: other_user)
              else 
                current_user.user_transactions + other_user_transactions
              end
            end
          end
        end
      end
    end
  end
end
