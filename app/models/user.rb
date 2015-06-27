class User < ActiveRecord::Base
  has_many :group_transactions
  has many :user_transactions
  has_and_belongs_to_many :groups
end
