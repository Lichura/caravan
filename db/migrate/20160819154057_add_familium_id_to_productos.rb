class AddFamiliumIdToProductos < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :familium_id, :int
  end
end
