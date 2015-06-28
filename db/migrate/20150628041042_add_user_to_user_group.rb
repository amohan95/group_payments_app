class AddUserToUserGroup < ActiveRecord::Migration
  def change
    add_reference :user_groups, :user, index: true, foreign_key: true
  end
end
