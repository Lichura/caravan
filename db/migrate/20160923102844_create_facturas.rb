class CreateFacturas < ActiveRecord::Migration[5.0]
  def change
    create_table :facturas do |t|
      t.integer :cuit
      t.datetime :fecha
      t.string :control
      t.string :vendedor
      t.float :subtotal
      t.float :bonificacion
      t.float :neto
      t.float :iva
      t.float :iibb
      t.float :total
      t.string :cae
      t.string :vencimiento_cae
      t.integer :pto_venta
      t.integer :numero
      t.string :tipo

      t.timestamps
    end
  end
end
