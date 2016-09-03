class Profile < ApplicationRecord
	has_many :users

	def self.search(perfil)
		where(["nombre LIKE ? OR descripcion Like ?", "%#{perfil}%", "%#{perfil}%"])
	end
end
