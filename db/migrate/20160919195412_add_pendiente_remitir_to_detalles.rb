class AddPendienteRemitirToDetalles < ActiveRecord::Migration[5.0]
  def change
    add_column :detalles, :pendiente_remitir, :integer
  end
end
