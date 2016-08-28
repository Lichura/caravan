class Pais < ApplicationRecord
	has_many :provincias, :dependent => :destroy
end
