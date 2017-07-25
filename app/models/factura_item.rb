class FacturaItem < ApplicationRecord
	belongs_to :factura,  optional: true
	belongs_to :producto,  optional: true

	#before_create :actualizar_remito_item
	#after_create :actualizar_remito_estado
	#after_create :actualizar_estado_pedido


	def actualizar_remito_item
		@remito_item = Remito.find(self.remito_id).remito_items.find_by(:producto_id => self.producto_id)
		@remito_item.pendiente_facturar -= self.cantidad
		@remito_item.save
	end


	def actualizar_remito_estado
		@remito = Remito.find(self.remito_id)
		puts("======================== remito numero" + @remito.to_s)
        if @remito.remito_items.all? {|producto| producto.pendiente_facturar == 0}
          @remito.estado = "Facturado"
          @remito.facturado = true
        else
          @remito.estado = "Facturado parcial"
        end
        @remito.save
    end

     def actualizar_estado_pedido
      self.factura.remitos.each do |remito|
        if remito.pedido.remitos.all? {|remito| remito.facturado?}
          remito.pedido.facturado!
          remito.pedido.facturado = true
        elsif remito.pedido.remitos.any? {|remito| remito.facturado? || remito.estado == "Pendiente" || remito.estado == "Facturado parcial"}
          remito.pedido.facturado_parcial!
        else
          remito.pedido.remitido!
        end
        remito.pedido.save
      end
    end

end
