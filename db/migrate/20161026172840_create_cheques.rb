class CreateCheques < ActiveRecord::Migration[5.0]
  def change
    create_table :cheques do |t|
      t.integer :pago_id
      t.float :monto
      t.integer :estado
      t.string :numero
      t.date :fecha

      t.timestamps
    end
  end
end
