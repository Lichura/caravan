class AddRangoToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :rango, :integer
  end
end
