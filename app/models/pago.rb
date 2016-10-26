class Pago < ApplicationRecord
	has_many :cheques
	accepts_nested_attributes_for :cheques,  allow_destroy: true
end
