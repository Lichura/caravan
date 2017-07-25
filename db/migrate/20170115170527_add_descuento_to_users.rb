class AddDescuentoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :descuento, :integer
  end
end
