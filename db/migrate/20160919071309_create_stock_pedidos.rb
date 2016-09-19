class CreateStockPedidos < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_pedidos do |t|
      t.string :vendedor
      t.integer :cantidadTotal
      t.float :precioTotal

      t.timestamps
    end
  end
end
