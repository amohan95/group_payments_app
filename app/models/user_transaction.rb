class UserTransaction < ActiveRecord::Base
	belongs_to :group_transaction
	belongs_to :user
	belongs_to :other_user, class_name: 'User'
end
