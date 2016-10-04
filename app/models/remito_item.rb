class RemitoItem < ApplicationRecord
	belongs_to :producto, optional: true
	belongs_to :pedido, optional: true





end
