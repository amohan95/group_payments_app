class CreateGroupTransactions < ActiveRecord::Migration
  def change
    create_table :group_transactions do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.string :purpose

      t.timestamps null: false
    end
  end
end
