class AddFinalizarToRemito < ActiveRecord::Migration[5.0]
  def change
    add_column :remitos, :finalizado, :boolean
  end
end
