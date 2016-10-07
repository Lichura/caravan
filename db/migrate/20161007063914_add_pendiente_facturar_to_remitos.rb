class AddPendienteFacturarToRemitos < ActiveRecord::Migration[5.0]
  def change
    add_column :remito_items, :pendiente_facturar, :integer
  end
end
