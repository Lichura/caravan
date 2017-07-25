class AddEstadoToFacturas < ActiveRecord::Migration[5.0]
  def change
    add_column :facturas, :estado, :integer
  end
end
