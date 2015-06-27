class AddGroupToGroupTransactions < ActiveRecord::Migration
  def change
    add_reference :group_transactions, :group, index: true, foreign_key: true
  end
end
