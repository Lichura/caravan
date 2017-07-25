class CreateInsumoHistoricos < ActiveRecord::Migration[5.0]
  def change
    create_table :insumo_historicos do |t|
      t.integer :insumo_id
      t.integer :precio
      t.datetime :fechaDesde
      t.datetime :fechaHasta

      t.timestamps
    end
  end
end
