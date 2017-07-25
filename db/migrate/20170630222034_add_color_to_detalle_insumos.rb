class AddColorToDetalleInsumos < ActiveRecord::Migration[5.0]
  def change
    add_column :detalle_insumos, :color, :string
  end
end
