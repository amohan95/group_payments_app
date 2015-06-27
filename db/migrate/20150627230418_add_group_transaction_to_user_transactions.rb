class AddGroupTransactionToUserTransactions < ActiveRecord::Migration
  def change
    add_reference :user_transactions, :group_transaction, index: true, foreign_key: true
  end
end
