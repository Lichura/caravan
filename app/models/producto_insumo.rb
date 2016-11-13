class ProductoInsumo < ApplicationRecord
	belongs_to :producto, optional: true
	belongs_to :insumo, optional: true
end
