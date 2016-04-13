class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.references :resourcetype, index: true
      t.string :name
      t.integer :capacity
      t.references :scheduleheader, index: true

      t.timestamps null: false
    end
    add_foreign_key :resources, :resourcetypes
    add_foreign_key :resources, :scheduleheaders
  end
end
