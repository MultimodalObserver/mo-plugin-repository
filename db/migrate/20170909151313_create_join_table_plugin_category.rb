class CreateJoinTablePluginCategory < ActiveRecord::Migration[5.1]
  def change
    create_join_table :plugins, :categories do |t|
      t.index [:plugin_id, :category_id]
    end
  end
end
