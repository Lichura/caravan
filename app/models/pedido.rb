class Pedido < ApplicationRecord
	has_many :productos, :through => :detalles
	has_many :detalles


	accepts_nested_attributes_for :detalles, reject_if: proc { |attributes| attributes['producto_id'] == "0" }

end
