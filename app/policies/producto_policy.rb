class ProductoPolicy < ApplicationPolicy

  def index?
    is_admin?
  end

  def edit?
     is_admin?
  end

  def create?
    is_admin?
  end

  def destroy?
    us_admin?
  end

end
