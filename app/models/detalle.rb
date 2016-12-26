class Detalle < ApplicationRecord
	include ActiveModel::Dirty
	belongs_to :producto, optional: true
	belongs_to :pedido, optional: true
	#after_create :controlar_stock
	after_update :actualizar_stock_insumo
	before_destroy :destruir_stock_insumo
	before_update :calcular_rango_automatico

  	has_many :detalle_insumos
  	accepts_nested_attributes_for :detalle_insumos,  allow_destroy: true

  	 after_destroy { |record|
              DetalleInsumo.destroy(record.detalle_insumos.pluck(:id))
            }

	def controlar_stock
		producto = Producto.find(self.producto_id)
		if self.cantidad > producto.stock_disponible
			puts( "El stock para el articulo #{producto.nombre} es insuficiente")
		end
	end


	def calcular_rango_automatico
    	producto =  Producto.find(self.producto_id)
    	usuario = self.pedido.user_id
    	if producto.correlativo?
    		if rango = UserRango.where(user_id: usuario, producto_id: producto.id).first
    			self.rango_desde = rango.rango + 1
    			self.rango_hasta = rango.rango + self.cantidad
    			rango.rango += self.cantidad
    			rango.save 
    		else
    			self.rango_desde = 1
    			self.rango_hasta = self.cantidad
    			rango_nuevo = UserRango.new
    				rango_nuevo.user_id = usuario
    				rango_nuevo.producto_id = producto.id
    				rango_nuevo.rango = self.cantidad
    			rango_nuevo.save
    		end
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

  def actualizar_stock_insumo
      if self.cantidad_changed?
      	  	if self.detalle_insumos.any?
	      	  self.detalle_insumos do |detalle|
		      	producto = Producto.find(detalle.producto_id)
		      	insumo = Insumo.find(detalle.insumo_id)
		      	coeficiente = ProductoInsumo.find_by(producto_id: producto.id, insumo_id: insumo.id).coeficiente
		        insumo.stock_disponible += (self.cantidad_was * coeficiente)
		        insumo.stock_reservado -= (self.cantidad_was  * coeficiente)
		        insumo.stock_disponible -= (self.cantidad * coeficiente)
		        insumo.stock_reservado += (self.cantidad  * coeficiente)
		        insumo.save
		      end
	  		else
		      	producto = Producto.find(detalle.producto_id)
		      	producto.stock_disponible += self.cantidad_was 
		        producto.stock_reservado -= self.cantidad_was 
		        producto.stock_disponible -= self.cantidad 
		        producto.stock_reservado += self.cantidad
		        producto.save
	      	end
      end
  end



end
