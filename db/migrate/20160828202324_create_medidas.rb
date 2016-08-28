class CreateMedidas < ActiveRecord::Migration[5.0]
  def change
    create_table :medidas do |t|
      t.integer :codigoAfip
      t.string :nombre
      t.string :abreviatura
      t.string :descripcion

      t.timestamps
    end
  end
end
