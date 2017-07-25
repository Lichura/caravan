class AddNotaCreditoIdToNotaCreditoItems < ActiveRecord::Migration[5.0]
  def change
    add_column :nota_credito_items, :nota_credito_id, :integer
  end
end
