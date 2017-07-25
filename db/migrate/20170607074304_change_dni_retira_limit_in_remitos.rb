class ChangeDniRetiraLimitInRemitos < ActiveRecord::Migration[5.0]
  def change
  	change_column :remitos, :dniRetira, :integer, limit: 8
  end
end
