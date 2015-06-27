class AddUserToUserTransactions < ActiveRecord::Migration
  def change
    add_reference :user_transactions, :user, index: true, foreign_key: true
  end
end
