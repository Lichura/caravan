class AddNumeroToNotaCredito < ActiveRecord::Migration[5.0]
  def change
    add_column :nota_creditos, :numero, :integer
  end
end
