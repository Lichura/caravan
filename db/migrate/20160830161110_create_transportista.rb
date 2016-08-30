class CreateTransportista < ActiveRecord::Migration[5.0]
  def change
    create_table :transportista do |t|
      t.string :nombre
      t.string :dni
      t.string :cuit
      t.string :destino
      t.string :numeroGuia
      t.float :dniRetira
      t.string :comentarios

      t.timestamps
    end
  end
end
