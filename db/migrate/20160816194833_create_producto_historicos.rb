class CreateProductoHistoricos < ActiveRecord::Migration[5.0]
  def change
    create_table :producto_historicos do |t|
      t.integer :producto_id
      t.float :precio
      t.datetime :fechaDesde
      t.datetime :fechaHasta

      t.timestamps
    end
  end
end
