class ChangeCuitInUsers < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :cuit, :double
  end

  def down
    change_column :users, :cuit, :string
  end
end
