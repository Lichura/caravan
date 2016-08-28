class CreateDetalles < ActiveRecord::Migration[5.0]
  def change
    create_table :detalles do |t|
      t.integer :pedido_id
      t.integer :producto_id
      t.integer :cantidad
      t.float :precio

      t.timestamps
    end
  end
end
