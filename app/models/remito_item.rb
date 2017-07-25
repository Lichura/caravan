class RemitoItem < ApplicationRecord
	attr_accessor :pendiente, :pedido

	belongs_to :producto, optional: true
	belongs_to :remito, optional: true


	after_save :modificar_stock_por_operacion_de_un_remito_con_pedidos

	#after_destroy :aumentar_stock_al_eliminar_remito

	after_save :setear_pedido
	after_save :modificar_pendiente_de_remitir_en_pedido
	after_destroy :modificar_pendiente_de_remitir_en_pedido_luego_de_eliminar
	before_save :pendiente_de_facturar


	def setear_pedido
		puts("estoy seteando el pedido")
		@pedido = Pedido.find(self.remito.pedido_id)
	end


	def modificar_stock_por_operacion_de_un_remito_con_pedidos
	#begin
	puts("se hace la iteracion por los pedidos")
	self.remito.pedido.detalles.each do |detalle|
		puts("a ver si llego hasta aca!")
		detalle.detalle_insumos.where(producto_id: detalle.producto_id).each do |detalle_insumo|
			@producto = Producto.new
			@insumo = Insumo.find(detalle_insumo.insumo_id)
			@producto.modificar_stock_articulo("insumo", @insumo.stock_reservado, detalle_insumo.insumo_id, detalle_insumo.cantidad_id, "resta")
			@producto.modificar_stock_articulo("insumo", @insumo.stock_fisico, detalle_insumo.insumo_id, detalle_insumo.cantidad_id, "resta")
		end
	end
	#rescue
	#	puts "Hubo un error al intentar modificar el stock luego de generar un remito"
	#end
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




  	#deberia pasar estos dos metodos al modelo de remito_items
  def modificar_pendiente_de_remitir_en_pedido
  	puts("estoy modificando el stock del pedido")
    @pedido.detalles.each do |producto|
        if producto.producto_id == self.producto_id && !self.cantidad.blank?
          producto.pendiente_remitir -= self.cantidad
        end
    end
    @pedido.save
    modificar_estado_pedido
  end



  def modificar_pendiente_de_remitir_en_pedido_luego_de_eliminar
    @pedido.detalles.each do |producto|
        if producto.producto_id == item.producto_id && !item.cantidad.blank?
          producto.pendiente_remitir += self.cantidad
        end
    end
    @pedido.save
    modificar_estado_pedido
  end


  	def modificar_estado_pedido
		if @pedido.detalles.all? {|producto| producto.pendiente_remitir == 0}
		    @pedido.remitido!
		    puts("estoy modificando el estado del pedido por remitido")
		elsif @pedido.detalles.any? {|producto| producto.pendiente_remitir == 0}
		   	@pedido.remitido_parcial!
		   	puts("estoy modificando el estado del pedido por remitido parcial")
		elsif self.remito.finalizado?
			@pedido.finalizado_por_ajuste!
		end
		@pedido.save
	end

end