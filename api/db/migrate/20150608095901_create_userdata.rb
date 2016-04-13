class CreateUserdata < ActiveRecord::Migration
  def change
    create_table :userdata do |t|
      t.string :nombre
      t.string :apellido1
      t.string :apellido2
      t.date :fecha_nacimiento
      t.string :dni
      t.string :sexo
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :userdata, :users
  end
end
