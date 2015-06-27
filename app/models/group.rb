class Group < ActiveRecord::Base
  has_many :users
  has_many :group_transactions
  has_many :user_transactions, through: :group_transactions
end
