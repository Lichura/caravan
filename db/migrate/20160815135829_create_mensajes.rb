class CreateMensajes < ActiveRecord::Migration[5.0]
  def change
    create_table :mensajes do |t|
      t.string :nombre
      t.string :empresa
      t.string :email
      t.string :telefono
      t.string :texto

      t.timestamps
    end
  end
end
