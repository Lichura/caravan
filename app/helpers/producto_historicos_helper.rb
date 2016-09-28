module ProductoHistoricosHelper

	def datos
		@productos = ProductoHistorico.all

		producto = Hash.new
		@productos.each do |producto|
			if producto.producto_id == 1
				producto << [producto.created_at, producto.precio]
			end
		end
	end
end
