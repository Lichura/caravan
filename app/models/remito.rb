class Remito < ApplicationRecord
	include ActiveModel::Dirty
	has_many :remito_items
	has_many :productos, :through => :remito_items
	belongs_to :pedido, optional: true
	has_and_belongs_to_many :facturas, optional: true


	before_create :generar_estado
	after_save :finalizar_pedido

	#after_update :modificar_estado
	after_update :finalizado_por_ajuste
	before_validation :marcar_productos_para_destruir
	accepts_nested_attributes_for :remito_items,  allow_destroy: true, reject_if: proc{ |att| att.all? { att[:cantidad].blank? } }

	private


	def generar_estado
		self.estado = "Pendiente de facturar"
		self.facturado = false
	end

	def marcar_productos_para_destruir
	    remito_items.each do |producto|
	      if producto.cantidad.blank? or (producto.cantidad == 0)
		        producto.mark_for_destruction
		   end
		end
	end


	 def finalizar_pedido
		    @pedido = Pedido.find(self.pedido_id)
		    if @pedido.detalles.all? {|producto| producto.pendiente_remitir == 0}
		    	@pedido.remitido!
		   	else
		    	@pedido.remitido_parcial!
		    end
	end

	def modificar_estado
		@pedido = Pedido.find(self.pedido_id)
		if @pedido.remitos.all? {|remito| remito.facturado == true }
			@pedido.facturado!
			@pedido.facturado = true
		elsif @pedido.remitos.any? {|remito| remito.facturado == true}
			@pedido.facturado_parcial!
		else
			@pedido.remitido!
		end
	end



	def finalizado_por_ajuste
    	if self.finalizado
      		@pedido.finalizado_por_ajuste!
    	end
  	end

	def self.search(remito)
		usuario = "" || User.where("CUIT LIKE ? OR razonSocial LIKE ?", "%#{remito}%", "%#{remito}%").first.id 
		where("pedido_id LIKE ? OR numero LIKE ?", "%#{remito}%", "%#{remito}%")
	end
end
