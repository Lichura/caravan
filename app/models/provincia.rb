class Provincia < ApplicationRecord
	belongs_to :pais
	has_many :ciudades, :dependent => :destroy
end
