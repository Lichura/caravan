class CreateRelacions < ActiveRecord::Migration[5.0]
  def change
    create_table :relacions do |t|
      t.integer :user_id
      t.integer :distribuidor_id

      t.timestamps
    end
  end
end
