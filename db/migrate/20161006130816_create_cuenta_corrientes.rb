class CreateCuentaCorrientes < ActiveRecord::Migration[5.0]
  def change
    create_table :cuenta_corrientes do |t|
      t.integer :user_id
      t.string :concepto
      t.integer :conceptoNumero
      t.float :monto

      t.timestamps
    end
  end
end
