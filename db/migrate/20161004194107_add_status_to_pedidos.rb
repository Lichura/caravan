class AddStatusToPedidos < ActiveRecord::Migration[5.0]
  def change
    add_column :pedidos, :status, :integer
  end
end
