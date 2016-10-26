class Detalle < ApplicationRecord
	include ActiveModel::Dirty
	belongs_to :producto, optional: true
	belongs_to :pedido, optional: true

	after_create :controlar_stock

	def controlar_stock
		producto = Producto.find(self.producto_id)
		if self.cantidad > producto.stock_disponible
			puts( "El stock para el articulo #{producto.nombre} es insuficiente")
		end
	end
end
