module API
  module V1
    class Transactions < Grape::API
      include API::V1::Defaults
      resource :transactions do
        desc "Creates a new transaction."
        params do
          requires :group_id, type: String, desc: "Group ID",
            allow_blank: false
          requires :description, type: String, desc: "Transaction description",
            allow_blank: false
          requires :transaction_map, type: Hash, desc: "Transaction map",
            allow_blank: false
        end
        post do
          map = params[:transaction_map]
          gt = GroupTransaction.create(
            purpose: params[:description],
            group: current_user.groups.find_by(params[:group_id]),
            user: current_user
          )

          user_transactions = Array.new

          map.each_pair do |key, value|
            user_transactions << UserTransaction.create(
              amount: value,
              settled: false,
              group_transaction: gt,
              user: current_user,
              other_user: key
            )
          end

          gt.user_transactions = user_transactions
          gt.save
        end


        route_param :id do
          desc "Edits a transaction."
          params do
            requires :transaction_map, type: Hash, desc: "Transaction map",
              allow_blank: false
          end
          put do
          end
        end


        route_param :id do
          desc "Removes a transaction."
          delete do
            transaction = Transactions.find_by(route_param)
            transaction.destroy
          end
        end
      end
    end
  end
end
