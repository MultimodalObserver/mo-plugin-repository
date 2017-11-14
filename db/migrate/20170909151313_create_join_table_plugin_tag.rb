class CreateJoinTablePluginTag < ActiveRecord::Migration[5.1]
  def change
    create_join_table :plugins, :tags do |t|
      t.index [:plugin_id, :tag_id], :unique => true
    end
  end
end
