class CondicionPago < ApplicationRecord


	def self.search(condicion)
		where("nombre LIKE ? OR descripcion LIKE ?", "%#{condicion}%", "%#{condicion}%")
	end
end
