class Familium < ApplicationRecord
	has_many :producto, :dependent => :destroy


	def self.search(familia)
		where("nombre LIKE ? OR descripcion LIKE ?", "%#{familia}%", "%#{familia}%")
	end
end
