class RemoveEnabledFromBranchoffices < ActiveRecord::Migration
  def change
    remove_column :branchoffices, :enabled, :integer
  end
end
