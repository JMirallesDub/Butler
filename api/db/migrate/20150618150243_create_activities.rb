class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.references :branchoffice, index: true
      t.references :room, index: true

      t.timestamps null: false
    end
    add_foreign_key :activities, :branchoffices
    add_foreign_key :activities, :rooms
  end
end
