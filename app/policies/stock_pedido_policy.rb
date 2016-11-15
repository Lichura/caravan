class StockPedidoPolicy < ApplicationPolicy
  
  def show?
    is_admin?
  end  

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
    is_admin?
  end

  def update?
    is_admin?
  end

  def new?
    is_admin?
  end

  def new_producto?
    is_admin?
  end

 end