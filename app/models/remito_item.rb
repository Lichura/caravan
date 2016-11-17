class RemitoItem < ApplicationRecord
	belongs_to :producto, optional: true
	belongs_to :remito, optional: true

	after_create :reducir_stock_al_remitir
	after_destroy :aumentar_stock_al_eliminar_remito

	def reducir_stock_al_remitir
		self.remito.pedido.detalles.each do |detalle|
			if detalle.detalle_insumos.any?
				detalle.detalle_insumos.each do |detalle_insumo|
					if detalle_insumo.producto_id == self.producto_id
						insumo = Insumo.find(detalle_insumo.insumo_id)
						coeficiente = ProductoInsumo.find_by(insumo_id: insumo.id, producto_id: self.producto_id).coeficiente
						insumo.stock_reservado -= self.cantidad * coeficiente
						insumo.stock_fisico -= self.cantidad * coeficiente
						insumo.save
					end
				end
			else
				producto = Producto.find(self.producto_id)
				producto.stock_reservado -= self.cantidad
				producto.stock_fisico -= self.cantidad
				producto.save
			end
		end
	end


	def aumentar_stock_al_eliminar_remito
		self.remito.pedido.detalles.each do |detalle|
			if detalle.detalle_insumos.any?
				detalle.detalle_insumos.each do |detalle_insumo|
					if detalle_insumo.producto_id == self.producto_id
						insumo = Insumo.find(detalle_insumo.insumo_id)
						coeficiente = ProductoInsumo.find_by(insumo_id: insumo.id, producto_id: self.producto_id).coeficiente
						insumo.stock_reservado += self.cantidad * coeficiente
						insumo.stock_fisico += self.cantidad * coeficiente
						insumo.save
					end
				end
			else
				producto = Producto.find(self.producto_id)
				producto.stock_reservado += self.cantidad
				producto.stock_fisico += self.cantidad
				producto.save
			end
		end


	end

end