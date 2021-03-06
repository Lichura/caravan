class Detalle < ApplicationRecord
	include ActiveModel::Dirty
	belongs_to :producto, optional: true
	belongs_to :pedido, optional: true
	#after_create :controlar_stock
	#after_update :actualizar_stock_insumo
	after_update :actualizar_stock_producto
	before_destroy :eliminar_detalle_insumos 
	#before_destroy :destruir_stock_insumo
	after_create :cantidad_insumo
	after_update :cantidad_insumo
	after_update :generar_rango_senasa

  	has_many :detalle_insumos
  	accepts_nested_attributes_for :detalle_insumos,  allow_destroy: true

  	
            

    def eliminar_detalle_insumos
    	puts("antes de eliminar los inusmos")
    	self.detalle_insumos.each do |insumo|
    		DetalleInsumo.destroy(insumo)
    	end	
    end

	def controlar_stock
		producto = Producto.find(self.producto_id)
		if self.cantidad > producto.stock_disponible
			puts( "El stock para el articulo #{producto.nombre} es insuficiente")
		end
	end

	def cantidad_insumo
		self.detalle_insumos.each do |insumo|
			coeficiente = ProductoInsumo.find_by(producto_id: insumo.producto_id, insumo_id: insumo.insumo_id).coeficiente
			insumo.cantidad_id = self.cantidad * coeficiente
		end
	end


#si es un producto senasa y no tiene un rango asociado deberia generar un rango 
#verificar que es de senasa
#verificar que solo se utiliza cuando se actualiza y no cuando se genera
	def generar_rango_senasa
		puts("generando rango")
		if !self.rango_desde.blank?
			puts("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ rango desde @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
				")
			puts("aca empieza: #{self.rango_desde} aca termina")
			if Producto.find(self.producto_id).correlativo == false
				rango_desde = self.rango_desde
				cantidad = self.cantidad
				cuig = User.find(self.pedido.user_id).cuig
				@metodo = Senasa.new
				#rango_desde = @metodo.disminuir_ultimo_numero(rango_desde)
				i = 0
				while i < cantidad
					rango_desde = @metodo.generar_nuevo_rango(rango_desde, self.pedido_id, self.pedido.user_id, cuig)
					i += 1
				end
			end
		end
	end


  
  def actualizar_stock_producto
  	@producto = Producto.find(self.producto_id)
  	if self.cantidad_changed? && !self.detalle_insumos.any?
  		@producto.stock_disponible += self.cantidad_was 
		@producto.stock_reservado -= self.cantidad_was 
		@producto.stock_disponible -= self.cantidad 
		@producto.stock_reservado += self.cantidad
		@producto.save
	end
  end



	def destruir_stock_insumo
	    producto = Producto.find(self.producto_id)
	    if producto.producto_insumos.any?
		    producto.producto_insumos.each do |insumo|
		        insumos = Insumo.find(insumo.insumo_id)
		        insumos.stock_disponible += (self.cantidad_was * insumo.coeficiente)
		        insumos.stock_reservado -= (self.cantidad_was  * insumo.coeficiente)
		        insumos.save
		    end
		else
		   	producto.stock_disponible += self.cantidad_was
		   	producto.stock_reservado -= self.cantidad_was
		   	producto.save
		end
	end

  # def actualizar_stock_insumo
  #     if self.cantidad_changed?
  #     	  	if self.detalle_insumos.any?
	 #      	  self.detalle_insumos do |detalle|
		#       	producto = Producto.find(detalle.producto_id)
		#       	insumo = Insumo.find(detalle.insumo_id)
		#       	coeficiente = ProductoInsumo.find_by(producto_id: producto.id, insumo_id: insumo.id).coeficiente
		#         insumo.stock_disponible += (self.cantidad_was * coeficiente)
		#         insumo.stock_reservado -= (self.cantidad_was  * coeficiente)
		#         insumo.stock_disponible -= (self.cantidad * coeficiente)
		#         insumo.stock_reservado += (self.cantidad  * coeficiente)
		#         insumo.save
		#       end
	 #  		else
		#       	producto = Producto.find(detalle.producto_id)
		#       	producto.stock_disponible += self.cantidad_was 
		#         producto.stock_reservado -= self.cantidad_was 
		#         producto.stock_disponible -= self.cantidad 
		#         producto.stock_reservado += self.cantidad
		#         producto.save
	 #      	end
  #     end
  # end




end
