class RemitoItem < ApplicationRecord
	belongs_to :producto, optional: true
	belongs_to :remito, optional: true

	after_create :prueba

	def prueba
		self.remito.pedido.detalles.each do |detalle|
			detalle.detalle_insumos.each do |detalle_insumo|
				if detalle_insumo.producto_id == self.producto_id
					insumo = Insumo.find(detalle_insumo.insumo_id)
					coeficiente = ProductoInsumo.find_by(insumo_id: insumo.id, producto_id: self.producto_id).coeficiente
					insumo.stock_reservado -= self.cantidad * coeficiente
					insumo.stock_fisico -= self.cantidad * coeficiente
					insumo.save
				end
			end
		end
	end

end