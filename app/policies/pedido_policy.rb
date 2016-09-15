class PedidoPolicy < ApplicationPolicy

	def index?
		is_admin? || is_distribuidor?
	end

	def new?
		is_admin? || is_distribuidor?
	end

	def create_pedidos?
		is_admin? || is_distribuidor?
	end

	def show?
		is_admin? || is_distribuidor?
	end

	def edit?
		is_admin? 
	end

	def destroy?
		is_admin?
	end

	def create?
		is_admin? || is_distribuidor?
	end

	def update
		is_admin?
	end


end