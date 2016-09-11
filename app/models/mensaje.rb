class Mensaje < ApplicationRecord

	def self.search(mensaje)
		where("nombre LIKE ? OR empresa LIKE ? OR email LIKE ? OR texto LIKE ?", "%#{mensaje}%", "%#{mensaje}%", "%#{mensaje}%", "%#{mensaje}%")
	end
end

