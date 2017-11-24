class AddStatusAndTypeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :status, :integer, null: false, default: User.statuses[:active]
    add_column :users, :role, :integer, null: false, default: User.roles[:normal_user]
  end
end
