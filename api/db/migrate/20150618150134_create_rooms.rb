class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.references :branchoffice, index: true

      t.timestamps null: false
    end
    add_foreign_key :rooms, :branchoffices
  end
end
