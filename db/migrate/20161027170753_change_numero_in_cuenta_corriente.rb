class ChangeNumeroInCuentaCorriente < ActiveRecord::Migration[5.0]
  def up
    change_column :cuenta_corrientes, :conceptoNumero, :string
  end

  def down
    change_column :cuenta_corrientes, :conceptoNumero, :integer
  end
end
