class ChangeCuitInUsersFromFloatToInteger < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :cuit, :integer
  end

  def down
    change_column :users, :cuit, :float
  end
end
