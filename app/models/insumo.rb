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

	def probando
		self.productos do |producto|
			Producto.prueba(producto)
		end
	end

	def chequear_uso_antes_de_eliminar
		if DetalleInsumo.where(insumo_id: self.id).any?
			alert: "El insumo no puede eliminarse ya que ha sido utilizado en un pedido."
			return false
		end
	end

	def actualizar_stock_producto
		insumo_disponible = []
		insumo_fisico = []
		insumo_reservado = []
		insumo_pedido = []
		self.producto_insumos.each do |productos|
			producto = Producto.find(productos.producto_id)
			producto.producto_insumos.each do |insumos|
				insumo = Insumo.find(insumos.insumo_id)
				insumo_disponible << insumo.stock_disponible / insumos.coeficiente
				insumo_fisico << insumo.stock_fisico / insumos.coeficiente
				insumo_reservado << insumo.stock_reservado / insumos.coeficiente
				insumo_pedido << insumo.stock_pedido / insumos.coeficiente
			end
			producto.stock_disponible = insumo_disponible.min
			producto.stock_fisico = insumo_fisico.min
			producto.stock_reservado = insumo_reservado.min
			producto.stock_pedido = insumo_pedido.min
			producto.save
		end
	end

	private
	def destruir_relacion_con_productos
     	self.producto_insumos.delete_all   
   	end
end
