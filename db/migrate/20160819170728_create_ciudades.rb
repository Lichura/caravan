class CreateCiudades < ActiveRecord::Migration[5.0]
  def change
    create_table :ciudades do |t|
      t.integer :pais_id
      t.integer :provincia_id
      t.string :nombre
      t.string :nombre_corto

      t.timestamps
    end
  end
end
