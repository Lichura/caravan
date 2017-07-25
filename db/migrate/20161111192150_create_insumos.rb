class CreateInsumos < ActiveRecord::Migration[5.0]
  def change
    create_table :insumos do |t|
      t.string :nombre
      t.string :descripcion
      t.float :precio
      t.integer :unidad_medida
      t.integer :stock_fisico, default: 0
      t.integer :stock_reservado, default: 0
      t.integer :stock_disponible, default: 0
      t.integer :stock_pedido, default: 0

      t.timestamps
    end
  end
end
