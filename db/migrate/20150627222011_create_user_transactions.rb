class CreateUserTransactions < ActiveRecord::Migration
  def change
    create_table :user_transactions do |t|
      t.datetime :updated_at
      t.integer :amount
      t.boolean :settled

      t.timestamps null: false
    end
  end
end
