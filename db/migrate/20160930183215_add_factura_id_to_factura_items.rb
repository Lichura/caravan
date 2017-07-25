class AddFacturaIdToFacturaItems < ActiveRecord::Migration[5.0]
  def change
    add_column :factura_items, :remito_id, :integer
  end
end
