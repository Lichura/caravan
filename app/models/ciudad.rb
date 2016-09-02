class Ciudad < ApplicationRecord
	belongs_to :provincia
	


	def self.search(ciudad)
		where("nombre LIKE ? OR nombre_corto LIKE ?", "%#{ciudad}%", "%#{ciudad}%")
	end
end
