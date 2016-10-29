class ChangeChequePorBooleans < ActiveRecord::Migration[5.0]
  def up
    change_column :cheques, :recibido, 'bool USING CAST(recibido AS bool)'
    change_column :cheques, :confirmado, 'bool USING CAST(confirmado AS bool)'
    change_column :cheques, :rechazado, 'bool USING CAST(rechazado AS bool)'
  end

  def down
    change_column :cheques, :recibido, :integer
    change_column :cheques, :confirmado, :integer
    change_column :cheques, :rechazado, :integer
  end
end
