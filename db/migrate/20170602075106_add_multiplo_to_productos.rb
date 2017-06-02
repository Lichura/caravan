class AddMultiploToProductos < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :multiplo, :integer, default: 1
  end
end
