class RemoveUserFromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :user, :string
  end
end
