class MenuPolicy < ApplicationPolicy

	def index?
		is_admin?
	end

	def distribuidores?
		is_distribuidor?
	end

end