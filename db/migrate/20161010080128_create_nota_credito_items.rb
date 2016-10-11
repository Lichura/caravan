class CreateNotaCreditoItems < ActiveRecord::Migration[5.0]
  def change
    create_table :nota_credito_items do |t|
      t.integer :producto_id
      t.integer :cantidad
      t.float :precio
      t.float :neto
      t.float :iva
      t.float :subtotal

      t.timestamps
    end
  end
end
