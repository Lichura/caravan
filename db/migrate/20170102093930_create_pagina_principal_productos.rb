class CreatePaginaPrincipalProductos < ActiveRecord::Migration[5.0]
  def change
    create_table :pagina_principal_productos do |t|
      t.string :imagen
      t.string :nombre
      t.string :descripcion

      t.timestamps
    end
  end
end
