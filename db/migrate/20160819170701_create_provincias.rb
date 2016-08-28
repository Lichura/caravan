class CreateProvincias < ActiveRecord::Migration[5.0]
  def change
    create_table :provincias do |t|
      t.integer :pais_id
      t.string :nombre
      t.string :nombre_corto

      t.timestamps
    end
  end
end
