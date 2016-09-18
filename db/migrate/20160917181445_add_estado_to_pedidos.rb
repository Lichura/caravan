class AddEstadoToPedidos < ActiveRecord::Migration[5.0]
  def change
    add_column :pedidos, :estado, :string
  end
end
