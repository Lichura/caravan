class NotaCreditoItem < ApplicationRecord
	belongs_to :producto, optional: true
	belongs_to :nota_credito, optional: true
end
