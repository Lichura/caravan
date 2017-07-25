class AddObservacionesToFacturas < ActiveRecord::Migration[5.0]
  def change
    add_column :facturas, :observaciones, :string
  end
end
