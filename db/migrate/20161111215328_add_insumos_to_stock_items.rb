class AddInsumosToStockItems < ActiveRecord::Migration[5.0]
  def change
    add_column :stock_items, :insumo_id, :integer
  end
end
