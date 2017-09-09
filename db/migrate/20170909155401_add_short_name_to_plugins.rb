class AddShortNameToPlugins < ActiveRecord::Migration[5.1]
  def change
    add_column :plugins, :short_name, :string
  end
end
