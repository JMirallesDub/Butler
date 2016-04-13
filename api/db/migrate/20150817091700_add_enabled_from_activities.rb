class AddEnabledFromActivities < ActiveRecord::Migration
  def change
    add_column :activities, :enabled, :integer, :default => 1
  end
end
