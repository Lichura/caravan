class CuentaCorriente < ApplicationRecord


private
def self.filtrar(cliente, fecha)
	where("user_id = ? AND created_at <= ?", "#{cliente}", "#{fecha}")
end
end
