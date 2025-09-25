class VotePolicy < Struct.new(:user, :record)
  def create?
    user.present?
  end

  def destroy?
    user.present?
  end
end
