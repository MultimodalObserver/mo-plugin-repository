class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string :url, :null => false
      t.references :user, index: true, :null => false
      t.timestamps
    end
  end
end
