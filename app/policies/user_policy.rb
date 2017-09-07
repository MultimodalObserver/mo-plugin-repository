class UserPolicy < ApplicationPolicy
  def change_status?
    return false if user.normal_user?
    return false if user.id == record.id
    return true if user.moderator? && record.normal_user?
    return false if user.moderator? && record.moderator?
    return true if user.admin?
    return false
  end

  def change_role?
    return false if record.admin?
    return true if user.admin?
    return false
  end
end
