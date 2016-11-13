class CreateProductoInsumos < ActiveRecord::Migration[5.0]
  def change
    create_table :producto_insumos do |t|
      t.integer :producto_id
      t.integer :insumo_id
      t.integer :coeficiente

      t.timestamps
    end
  end
end
