class AddColorToInsumos < ActiveRecord::Migration[5.0]
  def change
    add_column :insumos, :color, :string
  end
end
