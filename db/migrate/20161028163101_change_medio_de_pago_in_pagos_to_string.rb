class ChangeMedioDePagoInPagosToString < ActiveRecord::Migration[5.0]
  def up
    change_column :pagos, :medioDePago, :string
  end

  def down
    change_column :pagos, :medioDePago, :integer
  end
end
