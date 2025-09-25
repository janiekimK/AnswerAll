class ProfilePolicy < Struct.new(:user, :record)
  def show?
    user.present?
  end

  def edit?
    user.present? && owns_profile?
  end

  def update?
    user.present? && owns_profile?
  end

  private

  def owns_profile?
    record.id == user.id
  end
end
