class Detalle < ApplicationRecord
	include ActiveModel::Dirty
	belongs_to :producto, optional: true
	belongs_to :pedido, optional: true
end
