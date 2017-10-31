class PluginPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    return false if user.nil?
    return false if !user.active?
    return false if user.banned?
    return true
  end

  def update?
    return false if user.nil?
    return false if record.nil?
    return false if user.id != record.user_id
    return false if user.banned?
    return false if !user.active?
    return true
  end

  def destroy?
    update?
  end

end