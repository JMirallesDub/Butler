class AddEnabledFromBranchoffices < ActiveRecord::Migration
  def change
    add_column :branchoffices, :enabled, :integer, :default => 1
  end
end
