class PluginPolicy < ApplicationPolicy
  def create?
    return false if !user.active?
    return false if user.banned?
    return true
  end

=begin
  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
=end

end
