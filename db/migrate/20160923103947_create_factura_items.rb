class CreateFacturaItems < ActiveRecord::Migration[5.0]
  def change
    create_table :factura_items do |t|
      t.integer :factura_id
      t.integer :producto_id
      t.integer :cantidad
      t.float :precio
      t.float :neto
      t.float :iva
      t.float :subtotal
      t.integer :descuento

      t.timestamps
    end
  end
end
