class CreateBancos < ActiveRecord::Migration[5.0]
  def change
    create_table :bancos do |t|
      t.integer :codigo
      t.string :nombre

      t.timestamps
    end
  end
end
