class GroupTransaction < ActiveRecord::Base
  belongs_to :group
  has_many :user_transactions
end
