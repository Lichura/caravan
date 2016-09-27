class ChangeNumeroInRemitos < ActiveRecord::Migration[5.0]
  def up
    change_column :remitos, :numero, :integer
  end

  def down
    change_column :remitos, :numero, :string
  end
end
