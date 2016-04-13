class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :nombre
      t.string :user
      t.string :references
      t.timestamps null: false
    end
  end
end
