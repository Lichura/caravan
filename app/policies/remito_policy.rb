class RemitoPolicy < ApplicationPolicy

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

  def new?
    is_admin?
  end

  def show_all?
    is_admin? || is_distribuidor?
  end

 end