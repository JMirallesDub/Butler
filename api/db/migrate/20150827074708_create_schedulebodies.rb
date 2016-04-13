class CreateSchedulebodies < ActiveRecord::Migration
  def change
    create_table :schedulebodies do |t|
      t.references :scheduleheader, index: true
      t.time :time_ini
      t.time :time_end
      t.boolean :su
      t.boolean :mo
      t.boolean :tu
      t.boolean :we
      t.boolean :th
      t.boolean :fr
      t.boolean :sa

      t.timestamps null: false
    end
    add_foreign_key :schedulebodies, :scheduleheaders
  end
end
