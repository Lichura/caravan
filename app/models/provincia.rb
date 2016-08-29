class Provincia < ApplicationRecord
	belongs_to :pais
	has_many :ciudades, :dependent => :destroy


	def self.search(provincia)
		where(["nombre LIKE ? OR nombre_corto Like ?", "%#{provincia}%", "%#{provincia}%"])
	end
end
