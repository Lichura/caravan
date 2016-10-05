class FacturaItem < ApplicationRecord
	belongs_to :factura,  optional: true
	belongs_to :producto,  optional: true

	before_save :actualizar_remito_item

	def actualizar_remito_item
		@remito_item = Remito.find(self.remito_id).remito_items.find_by(:producto_id => self.producto_id)
		@remito_item.facturado = true
		@remito_item.save
	end


end
