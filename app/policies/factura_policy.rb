class FacturaPolicy < ApplicationPolicy

  def index?
    is_admin?
  end

  def show?
    is_admin? || is_distribuidor?
  end

  def edit?
     is_admin?
  end

  def create?
    is_admin?
  end

  def destroy?
    is_admin?
  end

  def nueva_factura?
    is_admin?
  end

 end