class Remito < ApplicationRecord
	has_many :remito_items
	has_many :productos, :through => :remito_items
	belongs_to :pedido

	accepts_nested_attributes_for :remito_items,  allow_destroy: true
end
