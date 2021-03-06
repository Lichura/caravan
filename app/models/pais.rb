class Pais < ApplicationRecord
	has_many :provincias, :dependent => :destroy
	has_many :ciudades, :through => :provincias

	validates :nombre, presence: true
	validates :abreviacion, presence: true

	def self.search(pais)
		where("nombre LIKE ? OR abreviacion LIKE ?", "%#{pais}%", "%#{pais}%")
	end
end
