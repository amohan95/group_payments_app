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
              if params[:other_user]
                user_transactions = UserTransaction.where('user_id=? AND' \
                  ' other_user_id=? OR user_id=? AND other_user_id=?',
                  current_user.id, params[:other_user],
                  params[:other_user], current_user.id)
              else
                user_transactions = UserTransaction.where('user_id=? OR' \
                  ' other_user_id=?', current_user.id, current_user.id)
              end
            end
          end
        end
      end
    end
  end
end
