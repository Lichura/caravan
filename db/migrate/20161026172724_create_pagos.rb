class CreatePagos < ActiveRecord::Migration[5.0]
  def change
    create_table :pagos do |t|
      t.integer :distribuidor_id
      t.integer :numero
      t.integer :medioDePago
      t.float :monto
      t.integer :estado

      t.timestamps
    end
  end
end
