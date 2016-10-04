class Remito < ApplicationRecord
	has_many :remito_items
	has_many :productos, :through => :remito_items
	belongs_to :pedido
	has_and_belongs_to_many :facturas, optional: true

	before_create :aumentar_numerador
	after_create :generar_estado
	after_update :modificar_estado
	before_validation :marcar_productos_para_destruir
	accepts_nested_attributes_for :remito_items,  allow_destroy: true

	private

	def aumentar_numerador
		self.numero = Remito.maximum(:numero).next || 1
	end

	def generar_estado
		self.estado = "Pendiente de remitir"
		self.facturado = false
	end

	def marcar_productos_para_destruir
    remito_items.each do |producto|
      if producto.cantidad.blank? or (producto.cantidad == 0)
	        producto.mark_for_destruction
	      end
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

	def self.search(remito)
		usuario = "" || User.where("CUIT LIKE ? OR razonSocial LIKE ?", "%#{remito}%", "%#{remito}%").first.id 
		where("pedido_id LIKE ? OR numero LIKE ?", "%#{remito}%", "%#{remito}%")
	end
end
