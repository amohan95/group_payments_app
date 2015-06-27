class Group < ActiveRecord::Base
  has_many :group_transactions
  has_many :user_transactions, through: :group_transactions
  has_many :user_groups
  has_many :users, through: :user_groups
end
