class AddFacturadoToRemitos < ActiveRecord::Migration[5.0]
  def change
    add_column :remitos, :facturado, :boolean
  end
end
