class FacturaItem < ApplicationRecord
	belongs_to :factura,  optional: true
	belongs_to :producto,  optional: true

	before_create :actualizar_remito_item
	after_create :actualizar_remito_estado


	def actualizar_remito_item
		@remito_item = Remito.find(self.remito_id).remito_items.find_by(:producto_id => self.producto_id)
		@remito_item.pendiente_facturar -= self.cantidad
		@remito_item.save
	end


	def actualizar_remito_estado
		@remito = Remito.find(self.remito_id)
        if @remito.remito_items.all? {|producto| producto.pendiente_facturar == 0}
          @remito.estado = "Facturado"
          @remito.facturado = true
        else
          @remito.estado = "Facturado parcial"
        end
        @remito.save
    end

end
