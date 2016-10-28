class AddBancoToCheques < ActiveRecord::Migration[5.0]
  def change
    add_column :cheques, :banco, :integer
  end
end
