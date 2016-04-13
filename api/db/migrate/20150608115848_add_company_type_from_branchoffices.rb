class AddCompanyTypeFromBranchoffices < ActiveRecord::Migration
  def change
    add_reference :branchoffices, :company_type, index: true
    add_foreign_key :branchoffices, :company_types
  end
end
