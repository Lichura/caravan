class CreateRemitos < ActiveRecord::Migration[5.0]
  def change
    create_table :remitos do |t|
      t.integer :pedido_id
      t.string :numero
      t.datetime :fecha
      t.string :transporte
      t.float :ivaTotal
      t.float :total
      t.integer :cantidadTotal

      t.timestamps
    end
  end
end
