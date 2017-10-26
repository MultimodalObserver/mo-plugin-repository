class TagPolicy < ApplicationPolicy
  def create?
    return false if user.nil?
    user.admin?
  end

  def update?
    return false if user.nil?
    user.admin?
  end

  def destroy?
    return false if user.nil?
    user.admin?
  end
end
