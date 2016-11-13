class CreateInsumos < ActiveRecord::Migration[5.0]
  def change
    create_table :insumos do |t|
      t.string :nombre
      t.string :descripcion
      t.float :precio
      t.integer :unidad_medida
      t.integer :stock_fisico
      t.integer :stock_reservado
      t.integer :stock_disponible
      t.integer :stock_pedido

      t.timestamps
    end
  end
end
