class User < ActiveRecord::Base
  has_many :group_transactions
  has_many :user_transactions
  has_many :other_user_transactions, source: :other_user
  has_many :user_groups
  has_many :groups, through: :user_groups
end
