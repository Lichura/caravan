class AddPendienteConfirmarToPedidos < ActiveRecord::Migration[5.0]
  def change
    add_column :pedidos, :pendiente_confirmar, :boolean
  end
end
