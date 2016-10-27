class AddEstadosACheques < ActiveRecord::Migration[5.0]
  def change
  	add_column :cheques, :recibido, :integer
	add_column :cheques, :confirmado, :integer
	add_column :cheques, :rechazado, :integer

  end
end
