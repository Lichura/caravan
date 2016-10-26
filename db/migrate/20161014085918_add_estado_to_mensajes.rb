class AddEstadoToMensajes < ActiveRecord::Migration[5.0]
  def change
    add_column :mensajes, :leido, :boolean
  end
end
