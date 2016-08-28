class AddFamiliaIdToProductos < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :familia_id, :string
    add_index :productos, :familia_id
  end
end
