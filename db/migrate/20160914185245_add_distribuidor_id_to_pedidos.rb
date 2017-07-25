class AddDistribuidorIdToPedidos < ActiveRecord::Migration[5.0]
  def change
    add_column :pedidos, :distribuidor_id, :integer
    add_column :pedidos, :pendiente_remitir, :integer
  end
end
