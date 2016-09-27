class Remito < ApplicationRecord
	has_many :remito_items
	has_many :productos, :through => :remito_items
	belongs_to :pedido
	has_many :facturas

	accepts_nested_attributes_for :remito_items,  allow_destroy: true

	def self.search(remito)
		usuario = "" || User.where("CUIT LIKE ? OR razonSocial LIKE ?", "%#{remito}%", "%#{remito}%").first.id 
		where("pedido_id LIKE ? OR numero LIKE ?", "%#{remito}%", "%#{remito}%")
	end
end
