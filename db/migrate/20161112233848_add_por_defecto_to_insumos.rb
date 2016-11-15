class AddPorDefectoToInsumos < ActiveRecord::Migration[5.0]
  def change
    add_column :producto_insumos, :por_defecto, :boolean
  end
end
