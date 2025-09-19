module Admin
  class UserPolicy < Struct.new(:user, :record)
    def index?
      user&.admin?
    end

    def edit?
      user&.admin?
    end

    def update?
      user&.admin?
    end

    class Scope < Struct.new(:user, :scope)
      def resolve
        user&.admin? ? scope.all : scope.none
      end
    end
  end
end
