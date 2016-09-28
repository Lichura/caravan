class CreateJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :remitos, :facturas do |t|
       t.index [:remito_id, :factura_id]
       t.index [:factura_id, :remito_id]
    end
  end
end
