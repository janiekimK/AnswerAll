module Admin
  class UserPolicy < Struct.new(:user, :record)
    def index?
      user&.role_admin?
    end

    def edit?
      user&.role_admin?
    end

    def update?
      user&.role_admin?
    end

    class Scope < Struct.new(:user, :scope)
      def resolve
        user&.role_admin? ? scope.all : scope.none
      end
    end
  end
end
