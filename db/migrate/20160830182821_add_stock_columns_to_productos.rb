class AddStockColumnsToProductos < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :stock_fisico, :integer
    add_column :productos, :stock_disponible, :integer
    add_column :productos, :stock_reservado, :integer
    add_column :productos, :stock_pedido, :integer
  end
end
