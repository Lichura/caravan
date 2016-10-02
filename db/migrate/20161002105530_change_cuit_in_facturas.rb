class ChangeCuitInFacturas < ActiveRecord::Migration[5.0]
  def up
    change_column :facturas, :cuit, :integer, :limit => 8
  end

  def down
    change_column :facturas, :cuit, :integer
  end
end
