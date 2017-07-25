class CreatePaginaPrincipals < ActiveRecord::Migration[5.0]
  def change
    create_table :pagina_principals do |t|
      t.string :imagen_principal
      t.string :nosotros_texto

      t.timestamps
    end
  end
end
