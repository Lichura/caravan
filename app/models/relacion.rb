class Relacion < ApplicationRecord
 belongs_to :user
 belongs_to :cliente,     :class_name => "User"
  
  
  	def self.search(relacion)
		where(["nombre LIKE ? OR nombre_corto Like ?", "%#{relacion}%", "%#{relacion}%"])
	end
end
