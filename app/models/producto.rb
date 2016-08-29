class Producto < ApplicationRecord
  belongs_to :familium
  has_many :pedidos, :through => :detalles
  has_many :detalles

  	def self.search(producto)
		where("nombre LIKE ? OR descripcion LIKE ?", "%#{producto}%", "%#{producto}%")
	end
end
