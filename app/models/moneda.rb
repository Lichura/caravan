class Moneda < ApplicationRecord

	def self.search(moneda)
		where("nombre LIKE ? OR descripcion LIKE ?", "%#{moneda}%", "%#{moneda}%")
	end
end
