class CreateScheduleheaders < ActiveRecord::Migration
  def change
    create_table :scheduleheaders do |t|
      t.references :branchoffice, index: true
      t.references :room, index: true
      t.references :activity, index: true
      t.date :date_ini
      t.date :date_end
      t.integer :capacity

      t.timestamps null: false
    end
  end
end
