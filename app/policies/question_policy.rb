class QuestionPolicy < Struct.new(:user, :record)
  def index?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    user.present?
  end

  def edit?
    update?
  end

  def update?
    user.present? && (record.user_id == user.id || user.role_admin?)
  end

  def destroy?
    user.present? && (record.user_id == user.id || user.role_admin?)
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope.all
    end
  end
end
