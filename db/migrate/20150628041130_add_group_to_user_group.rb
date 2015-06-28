class AddGroupToUserGroup < ActiveRecord::Migration
  def change
    add_reference :user_groups, :group, index: true, foreign_key: true
  end
end
