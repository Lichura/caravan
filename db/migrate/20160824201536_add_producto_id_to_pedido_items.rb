class CreatePedidoItems < ActiveRecord::Migration[5.0]
  def change
    create_table :pedido_items do |t|
      t.integer :pedido_id
      t.integer :cantidad
      t.float :precio
      t.integer :producto_id


      t.timestamps
    end
  end
end

