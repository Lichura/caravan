class ChangeColumntToPedidoItems < ActiveRecord::Migration[5.0]
  def change
    add_column :pedido_items, :producto_id, :integer
    remove_column :pedido_items, :item_id, :integer
  end
end
