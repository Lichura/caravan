class CreateStockItems < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_items do |t|
      t.integer :producto_id
      t.integer :stock_pedido_id
      t.integer :cantidad
      t.float :precio
      t.float :subtotal
      t.boolean :recibido
      t.float :cantidadRecibida

      t.timestamps
    end
  end
end
