class ProductoInsumo < ApplicationRecord
	belongs_to :producto, optional: true
	belongs_to :insumo, optional: true

	before_validation :asignar_valor_cero_a_los_nulos
	def asignar_valor_cero_a_los_nulos
		if self.coeficiente == nil or self.coeficiente == ""
			self.coeficiente = 0
		end
	end
end
