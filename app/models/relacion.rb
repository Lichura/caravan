class Relacion < ApplicationRecord
 belongs_to :user
 belongs_to :cliente,     :class_name => "User"
  
  
  	def self.search(relacion)
  		usuario = User.where("razonSocial LIKE ?", "%#{relacion}%").first.id
		where(["user_id LIKE ? OR cliente_id Like ?", "%#{usuario}%", "%#{usuario}%"])
	end
end
