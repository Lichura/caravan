class FacturaItem < ApplicationRecord
	belongs_to :factura,  optional: true
	belongs_to :producto,  optional: true

	after_save :actualizar_remito_item
	after_save :cambiar_estado_remito

	def actualizar_remito_item
		@remito_item = Remito.find(self.remito_id).remito_items.find_by(:producto_id => self.producto_id)
		@remito_item.facturado = true
		@remito_item.save
	end


	def cambiar_estado_remito
		@remito = Remito.find(self.remito_id)
		if @remito.remito_items.all? {|item| item.facturado == true }
			@remito.estado = "Facturado"
			@remito.facturado = true
		elsif @remito.remito_items.any? {|item| item.facturado == true}
			@remito.estado = "Facturado parcial - Pendiente de facturar"
		else
			@remito.estado = "Pendiente de facturar"
		end
		@remito.save
	end
end
