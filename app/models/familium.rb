class Familium < ApplicationRecord
	has_many :producto, :dependent => :destroy
end
