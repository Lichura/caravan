class CreateNotaCreditos < ActiveRecord::Migration[5.0]
  def change
    create_table :nota_creditos do |t|
      t.integer :cliente_id
      t.integer :factura_id
      t.integer :distribuidor_id
      t.integer :vendedor_id
      t.datetime :fecha
      t.integer :estado
      t.integer :tipo
      t.float :neto
      t.float :iva
      t.float :total

      t.timestamps
    end
  end
end
