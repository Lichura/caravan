class Pedido < ApplicationRecord
	has_many :productos, :through => :detalles
	has_many :detalles

	accepts_nested_attributes_for :detalles, reject_if: proc { |producto| producto['producto_id'].to_i == 0 },  allow_destroy: true


	def self.search(pedido)
		where("cuit LIKE ? OR comprobanteNumero LIKE ?", "%#{pedido}%", "%#{pedido}%")
	end
end

