class ChangeRelacionsModel < ActiveRecord::Migration[5.0]
  def change
  	add_column :relacions, :cliente_id, :integer
    remove_column :relacions, :distribuidor_id, :integer
  end
end
