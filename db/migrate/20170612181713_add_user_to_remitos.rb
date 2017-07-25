class AddUserToRemitos < ActiveRecord::Migration[5.0]
  def change
    add_column :remitos, :user_id, :integer
  end
end
