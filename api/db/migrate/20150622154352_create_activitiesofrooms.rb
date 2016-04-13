class CreateActivitiesofrooms < ActiveRecord::Migration
  def change
    create_table :activitiesofrooms do |t|
      t.references :activity, index: true
      t.references :room, index: true

      t.timestamps null: false
    end
    add_foreign_key :activitiesofrooms, :activities
    add_foreign_key :activitiesofrooms, :rooms
  end
end
