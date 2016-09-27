class Factura < ApplicationRecord
	belongs_to :remito
	has_many :factura_items
	has_many :productos, :through => :factura_items

	accepts_nested_attributes_for :factura_items,  allow_destroy: true
end
