class AddEnabledFromRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :enabled, :integer, :default => 1
  end
end
