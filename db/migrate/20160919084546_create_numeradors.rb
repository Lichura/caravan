class CreateNumeradors < ActiveRecord::Migration[5.0]
  def change
    create_table :numeradors do |t|
      t.string :comprobante
      t.integer :puntoDeVenta
      t.integer :numero

      t.timestamps
    end
  end
end
