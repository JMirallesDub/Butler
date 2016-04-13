class CreateBranchoffices < ActiveRecord::Migration
  def change
    create_table :branchoffices do |t|
      t.string :name
      t.string :direccion
      t.integer :cp
      t.references :company, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :branchoffices, :companies
    add_foreign_key :branchoffices, :users
  end
end
