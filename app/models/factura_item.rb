class FacturaItem < ApplicationRecord
	belongs_to :factura
	belongs_to :producto
end
