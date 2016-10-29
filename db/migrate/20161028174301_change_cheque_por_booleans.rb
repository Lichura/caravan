class ChangeChequePorBooleans < ActiveRecord::Migration[5.0]
  def up
    change_column :cheques, :recibido, 'bool USING CAST(column_name AS bool)'
    change_column :cheques, :confirmado, 'bool USING CAST(column_name AS bool)'
    change_column :cheques, :rechazado, 'bool USING CAST(column_name AS bool)'
  end

  def down
    change_column :cheques, :recibido, :integer
    change_column :cheques, :confirmado, :integer
    change_column :cheques, :rechazado, :integer
  end
end
