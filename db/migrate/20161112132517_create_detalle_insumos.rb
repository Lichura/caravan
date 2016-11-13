class CreateDetalleInsumos < ActiveRecord::Migration[5.0]
  def change
    create_table :detalle_insumos do |t|
      t.integer :pedido_id
      t.integer :producto_id
      t.integer :insumo_id
      t.integer :cantidad_id

      t.timestamps
    end
  end
end
