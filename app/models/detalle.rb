class Detalle < ApplicationRecord
	belongs_to :producto, optional: true
	belongs_to :pedido, optional: true

	after_update :cambiar_estado_pedido

	def cambiar_estado_pedido
		@pedido = Pedido.find(self.pedido_id)
		if @pedido.detalles.all? {|item| !item.rango_hasta.empty? }
			@pedido.confirmado!
		else
			@pedido.activo!
		end
	end
end
