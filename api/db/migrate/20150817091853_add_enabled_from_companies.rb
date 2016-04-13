class AddEnabledFromCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :enabled, :integer, :default => 1
  end
end
