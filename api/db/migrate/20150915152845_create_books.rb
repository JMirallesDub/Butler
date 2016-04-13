class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.references :scheduleheader, index: true
      t.references :schedulebody, index: true
      t.references :resource, index: true
      t.references :user, index: true
      t.references :bookstatus, index: true
      t.date :date_ini
      t.date :date_end
      t.time :time_ini
      t.time :time_end

      t.timestamps null: false
    end
    add_foreign_key :books, :scheduleheaders
    add_foreign_key :books, :schedulebodies
    add_foreign_key :books, :resources
    add_foreign_key :books, :users
    add_foreign_key :books, :bookstatuses
  end
end
