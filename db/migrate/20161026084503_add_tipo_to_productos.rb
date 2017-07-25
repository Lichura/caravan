class AddTipoToProductos < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :tipo, :integer
  end
end
