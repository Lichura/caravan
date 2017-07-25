class NotaCreditoItem < ApplicationRecord

	belongs_to :producto, optional: true
	belongs_to :nota_credito, optional: true

	after_create :aumentar_stock


	def aumentar_stock
		@producto = Producto.find(self.producto_id)
		if @producto.rango?
			@producto.stock_fisico += self.cantidad
		end
	end

end
