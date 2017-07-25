class AddRangoToDetalles < ActiveRecord::Migration[5.0]
  def change
    add_column :detalles, :rango_desde, :string
    add_column :detalles, :rango_hasta, :string
  end
end
