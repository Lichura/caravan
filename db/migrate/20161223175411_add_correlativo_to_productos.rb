class AddCorrelativoToProductos < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :correlativo, :boolean
  end
end
