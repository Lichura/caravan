class AddPedidoMinimoToProductos < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :pedido_minimo, :integer
  end
end
