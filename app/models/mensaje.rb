class Mensaje < ApplicationRecord

	after_create :no_leido

	def self.search(mensaje)
		where("nombre LIKE ? OR empresa LIKE ? OR email LIKE ? OR texto LIKE ?", "%#{mensaje}%", "%#{mensaje}%", "%#{mensaje}%", "%#{mensaje}%")
	end


	def no_leido
		self.leido! = false
	end
end

