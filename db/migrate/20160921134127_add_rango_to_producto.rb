class AddRangoToProducto < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :rango, :boolean
  end
end
