class AddColorToProductos < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :color, :string
  end
end
