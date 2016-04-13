class AddEnabledFromResources < ActiveRecord::Migration
  def change
    add_column :resources, :enabled, :boolean, default: true
  end
end
