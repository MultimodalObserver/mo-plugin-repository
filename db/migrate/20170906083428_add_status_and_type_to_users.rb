class AddStatusAndTypeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :status, :integer, null: false, default: 0
    add_column :users, :role, :integer, null: false, default: 0
  end
end
