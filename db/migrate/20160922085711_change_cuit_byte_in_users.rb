class ChangeCuitByteInUsers < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :cuit, :integer, :limit => 8
  end

  def down
    change_column :users, :cuit, :integer
  end
end
