class CreatePlugins < ActiveRecord::Migration[5.1]
  def change
    create_table :plugins do |t|
      t.string :name, :null => false, unique: true
      t.string :repository_url, :null => false
      t.string :home_page
      t.string :description
      t.references :user, index: true, :null => false
      t.timestamps
    end
  end
end