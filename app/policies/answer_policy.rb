class AnswerPolicy < Struct.new(:user, :record)
  def create?
    user.present?
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
