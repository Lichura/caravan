class Factura < ApplicationRecord
	has_and_belongs_to_many :remitos, optional: true
	has_many :factura_items
	has_many :productos, :through => :factura_items

	accepts_nested_attributes_for :factura_items,  allow_destroy: true
end
