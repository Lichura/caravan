class AddDistribuidorIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :distribuidor_id, :integer
  end
end
