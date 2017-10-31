class CreatePlugins < ActiveRecord::Migration[5.1]
  def change
    create_table :plugins do |t|
      t.string :name, :null => false, unique: true, index: true
      t.string :short_name, :null => false, unique: true, index: true

      t.integer :repo_type, null: false, default: 0
      t.string :repo_user, :null => false
      t.string :repo_name, :null => false

      t.string :home_page
      t.string :description
      t.references :user, index: true, :null => false
      t.timestamps
    end
  end
end
