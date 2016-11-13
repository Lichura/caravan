class AddDetalleIdToDetalleInsumos < ActiveRecord::Migration[5.0]
  def change
    add_column :detalle_insumos, :detalle_id, :integer
  end
end
