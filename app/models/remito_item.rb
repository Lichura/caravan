class RemitoItem < ApplicationRecord
	attr_accessor :pendiente

	belongs_to :producto, optional: true
	belongs_to :remito, optional: true

	after_save :modificar_stock_por_operacion_de_un_remito_con_pedidos, :unless => !self.remito.pedidos.any?
	#after_destroy :aumentar_stock_al_eliminar_remito

	before_save :pendiente_de_facturar



	def modificar_stock_por_operacion_de_un_remito_con_pedidos(funcion)
		case funcion
		when "crear"
			operacion = "suma"
		when "eliminar"
			operacion = "resta"
		end


		self.pedido.each do |pedido|
			detalle_insumos.where(pedido_id: pedido.id).each do |detalle|
				modificar_stock_articulo("insumo", "reservado", detalle.insumo_id, detalle.cantidad, operacion)
				modificar_stock_articulo("insumo", "fisico", detalle.insumo_id, detalle.cantidad, operacion)
			end
		end
	end



	def reducir_stock_al_remitir
		if !self.remito.pedido.nil?
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
		else
			producto = Producto.find(self.producto_id)
			producto.stock_fisico -= self.cantidad
			producto.save
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


	#a cada producto dentro del detalle le asigno la cantidad del remito como pendiente de facturar
	def pendiente_de_facturar
        self.pendiente_facturar = self.cantidad
  	end

end