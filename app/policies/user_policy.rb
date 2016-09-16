class UserPolicy < ApplicationPolicy


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
           scope.where(:id => user.relacions.select(:user_id))
      end
    end

  end
def mostrar_usuarios?
  user.id == user.relacions.user_id
end
end