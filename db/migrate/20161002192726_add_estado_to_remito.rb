class AddEstadoToRemito < ActiveRecord::Migration[5.0]
  def change
    add_column :remitos, :estado, :string
  end
end
