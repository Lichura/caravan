class AddFacturadoToRemitoItems < ActiveRecord::Migration[5.0]
  def change
    add_column :remito_items, :facturado, :boolean
  end
end
