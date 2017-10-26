class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name, :null => false, unique: true
      t.string :short_name, :null => false, unique: true
      t.timestamps
    end
  end
end
