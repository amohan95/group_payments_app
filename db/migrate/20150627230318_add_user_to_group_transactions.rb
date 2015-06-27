class AddUserToGroupTransactions < ActiveRecord::Migration
  def change
    add_reference :group_transactions, :user, index: true, foreign_key: true
  end
end
