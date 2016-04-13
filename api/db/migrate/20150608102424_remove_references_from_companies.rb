class RemoveReferencesFromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :references, :string
  end
end
