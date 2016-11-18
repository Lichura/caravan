class Insumo < ApplicationRecord
	has_many :producto_insumos
	has_many :productos, :through => :producto_insumos
	has_many :stock_pedidos, :through => :stock_items
  	has_many :stock_items , dependent: :destroy
  	has_many :detalles, :through => :detalle_insumos
  	has_many :detalle_insumos

	after_update :actualizar_stock_producto
	before_destroy :chequear_uso_antes_de_eliminar
	after_destroy { |record|
  					ProductoInsumo.destroy(record.producto_insumos.pluck(:id))
				  }
	after_update :agregar_a_historico
	after_update :actualizar_precio_producto
	before_create :generar_stock_al_crear_insumo


	def probando
		self.productos do |producto|
			Producto.prueba(producto)
		end
	end

	def actualizar_precio_producto
		self.productos.each do |producto|
			producto.precio = producto.insumos.sum(&:precio)
			producto.save
		end
	end

	def chequear_uso_antes_de_eliminar
		if DetalleInsumo.any? {|detalle| detalle.insumo_id == self.id}
			errors.add(:id, 'Se encuentra en uso.')
			false
		else
      		true
    	end
	end

	
	private
	def actualizar_stock_producto
		self.producto_insumos.each do |productos|
			insumo_disponible = []
			insumo_fisico = []
			insumo_reservado = []
			insumo_pedido = []
			producto = Producto.find(productos.producto_id)
			producto.producto_insumos.each do |insumos|
				insumo = Insumo.find(insumos.insumo_id)
				if insumos.coeficiente != 0
					insumo_disponible << insumo.stock_disponible / insumos.coeficiente
					insumo_fisico << insumo.stock_fisico / insumos.coeficiente
					insumo_reservado << insumo.stock_reservado / insumos.coeficiente
					insumo_pedido << insumo.stock_pedido / insumos.coeficiente
				end
			end
			producto.stock_disponible = insumo_disponible.min
			producto.stock_fisico = insumo_fisico.min
			producto.stock_reservado = insumo_reservado.min
			producto.stock_pedido = insumo_pedido.min
			producto.save
		end
	end


	def destruir_relacion_con_productos
     	self.producto_insumos.delete_all   
   	end


   	def agregar_a_historico
	    if self.precio_changed?
	      @historico = InsumoHistorico.create!([{insumo_id: self.id, precio: self.precio, fechaDesde: self.updated_at, fechaHasta: DateTime.now}])
	    end
  	end

  	def generar_stock_al_crear_insumo
  		self.stock_pedido = 0
  		self.stock_reservado = 0
  		self.stock_fisico = 0
  		self.stock_disponible = 0
  	end
end
