class CreateUserRangos < ActiveRecord::Migration[5.0]
  def change
    create_table :user_rangos do |t|
      t.integer :user_id
      t.integer :producto_id
      t.integer :rango

      t.timestamps
    end
  end
end
