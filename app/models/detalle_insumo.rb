class DetalleInsumo < ApplicationRecord
	belongs_to :insumo, optional: true
	belongs_to :detalle, optional: true
	belongs_to :producto, optional: true

	

	def cantidad_insumo
		coeficiente = ProductoInsumo.find_by(producto_id: self.producto_id, insumo_id: self.insumo_id).coeficiente
		self.cantidad_id = self.detalle.cantidad * coeficiente
	end

end
