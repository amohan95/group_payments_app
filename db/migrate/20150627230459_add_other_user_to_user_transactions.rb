class AddOtherUserToUserTransactions < ActiveRecord::Migration
  def change
    add_reference :user_transactions, :other_user, index: true, foreign_key: true
  end
end
