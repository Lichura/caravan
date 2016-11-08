class ChangeChequePorBooleans < ActiveRecord::Migration[5.0]
  def up
    change_column :cheques, :recibido, :boolean
    change_column :cheques, :confirmado, :boolean
    change_column :cheques, :rechazado, :boolean
  end

  def down
    change_column :cheques, :recibido, :integer
    change_column :cheques, :confirmado, :integer
    change_column :cheques, :rechazado, :integer
  end
end
