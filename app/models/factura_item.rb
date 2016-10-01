class FacturaItem < ApplicationRecord
	belongs_to :factura,  optional: true
	belongs_to :producto,  optional: true
end
