class CreateResourcetypes < ActiveRecord::Migration
  def change
    create_table :resourcetypes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
