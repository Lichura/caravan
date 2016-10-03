class Remito < ApplicationRecord
	has_many :remito_items
	has_many :productos, :through => :remito_items
	belongs_to :pedido
	has_and_belongs_to_many :facturas, optional: true

	before_create :aumentar_numerador
	after_create :generar_estado
	after_update :modificar_estado
	accepts_nested_attributes_for :remito_items,  allow_destroy: true

	private

	def aumentar_numerador
		self.numero = Remito.maximum(:numero).next || 1
	end

	def generar_estado
		self.estado = "Pendiente de remitir"
		self.facturado = false
	end

	def modificar_estado
		@pedido = Pedido.find(self.pedido_id)
		if @pedido.remitos.all? {|remito| remito.facturado == true }
			@pedido.estado = "Facturado"
			@pedido.facturado = true
		elsif @pedido.remitos.any? {|remito| remito.facturado == true}
			@pedido.estado = "Facturado parcial - Pendiente de facturar"
		else
			@pedido.estado = "Pendiente de facturar"
		end
		@pedido.save
	end

	def self.search(remito)
		usuario = "" || User.where("CUIT LIKE ? OR razonSocial LIKE ?", "%#{remito}%", "%#{remito}%").first.id 
		where("pedido_id LIKE ? OR numero LIKE ?", "%#{remito}%", "%#{remito}%")
	end
end
