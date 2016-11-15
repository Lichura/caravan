class DetalleInsumo < ApplicationRecord
	belongs_to :insumo, optional: true
	belongs_to :detalle, optional: true
	belongs_to :producto, optional: true



end
