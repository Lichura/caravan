class AddCodigoAfipToProvincias < ActiveRecord::Migration[5.0]
  def change
    add_column :provincias, :codigoAfip, :int
  end
end
