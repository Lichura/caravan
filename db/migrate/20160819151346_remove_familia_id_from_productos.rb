class RemoveFamiliaIdFromProductos < ActiveRecord::Migration[5.0]
  def change
    remove_column :productos, :familia_id, :int
  end
end
