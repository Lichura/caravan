class UserPolicy < ApplicationPolicy

  def index?
    is_admin? || is_distribuidor?
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
       @user = user
       @scope = scope
    end
    def resolve
      if user.admin?
        scope.all
      else
        user.clientes
      end
    end

  end
def mostrar_usuarios?
  user.id == user.relacions.user_id
end
end