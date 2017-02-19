class ChangeNumeroInRango < ActiveRecord::Migration[5.0]
  def up
  	change_column :rangos, :numero, :string
  end

  def down
    change_column :rangos, :numero, :integer
  end
end
