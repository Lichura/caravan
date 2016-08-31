class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :razonSocial, :string
    add_column :users, :direccion, :string
    add_column :users, :localidad_id, :int
    add_column :users, :cuig, :string
    add_column :users, :renspa, :string
    add_column :users, :cuit, :float
    add_column :users, :telefono, :string
    add_column :users, :codigoPostal, :string
    add_column :users, :provincia_id, :int
    add_column :users, :pais_id, :int
    add_column :users, :encargado, :string
    add_column :users, :celular, :string
    add_column :users, :numeroCv, :string
    add_column :users, :profile_id, :int
  end
end
