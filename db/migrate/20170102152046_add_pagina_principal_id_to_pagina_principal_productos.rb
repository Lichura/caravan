class AddPaginaPrincipalIdToPaginaPrincipalProductos < ActiveRecord::Migration[5.0]
  def change
    add_column :pagina_principal_productos, :pagina_principal_id, :integer
  end
end
