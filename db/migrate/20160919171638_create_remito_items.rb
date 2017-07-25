class CreateRemitoItems < ActiveRecord::Migration[5.0]
  def change
    create_table :remito_items do |t|
      t.integer :remito_id
      t.integer :producto_id
      t.integer :cantidad
      t.float :precio
      t.float :subtotal
      t.float :iva
      t.float :precioNeto

      t.timestamps
    end
  end
end
