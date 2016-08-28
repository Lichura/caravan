class CreatePedidos < ActiveRecord::Migration[5.0]
  def change
    create_table :pedidos do |t|
      t.date :fecha
      t.integer :cantidadTotal
      t.integer :tipo
      t.string :titular
      t.string :cuit
      t.float :precioTotal
      t.boolean :remitido
      t.boolean :facturado
      t.integer :comprobanteNumero
      t.integer :condicionCompra
      t.integer :sucursal

      t.timestamps
    end
  end
end
