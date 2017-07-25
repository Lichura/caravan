class CreateRangos < ActiveRecord::Migration[5.0]
  def change
    create_table :rangos do |t|
      t.string :letras
      t.integer :numero
      t.integer :digito
      t.integer :pedido_id
      t.integer :user_id

      t.timestamps
    end
  end
end
