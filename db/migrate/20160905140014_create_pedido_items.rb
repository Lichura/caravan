class CreatePedidoItems < ActiveRecord::Migration[5.0]
  def change
    create_table :pedido_items do |t|
      t.integer :item_id
      t.integer :pedido_id
      t.integer :cantidad
      t.float :precio

      t.timestamps
    end
  end
end
