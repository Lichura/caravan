class Detalle < ApplicationRecord
	include ActiveModel::Dirty
	belongs_to :producto, optional: true
	belongs_to :pedido, optional: true

	after_update :actualizar_pedido


	#se puso un unless pendiente_remitir changed adelante porque sino, cada vez que se remitia,
	#el estado pasaba a confirmado, ya que validaba solo que cambiaba y no le importaba que vinieses de un remito
  	def  actualizar_pedido
  		unless self.pendiente_remitir_changed?
		  	@pedido = Pedido.find(self.pedido_id)
		    if @pedido.detalles.any? { |item| Producto.find(item.producto_id).rango == true && (item.rango_desde.blank? || item.rango_hasta.blank?)}
		      @pedido.activo!
		    else
		      @pedido.confirmado!
	    	end
    	end
  	end


end
