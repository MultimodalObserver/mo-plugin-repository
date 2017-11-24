class PluginPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def accept_plugin?
    return false if user.nil?
    return true if user.admin?
    return false    
  end

  def reject_plugin?
    accept_plugin?
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

  def add_tag?
    update?
  end

  def remove_tag?
    update?
  end

  def destroy?
    update?
  end

end
