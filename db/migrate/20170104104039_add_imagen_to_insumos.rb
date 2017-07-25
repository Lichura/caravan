class AddImagenToInsumos < ActiveRecord::Migration[5.0]
  def change
    add_column :insumos, :imagen, :string
  end
end
