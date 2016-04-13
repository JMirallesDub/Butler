class CreateCompanyTypes < ActiveRecord::Migration
  def change
    create_table :company_types do |t|
      t.string :tipo

      t.timestamps null: false
    end
  end
end
