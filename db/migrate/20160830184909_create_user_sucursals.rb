class CreateUserSucursals < ActiveRecord::Migration[5.0]
  def change
    create_table :user_sucursals do |t|
      t.integer :user_id
      t.string :nombre
      t.string :direccion
      t.string :telefono
      t.string :encargado

      t.timestamps
    end
  end
end
