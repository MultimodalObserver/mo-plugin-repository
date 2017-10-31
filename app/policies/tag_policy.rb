class TagPolicy < ApplicationPolicy
  def create?
    return false if user.nil?

    # El unico requerimiento es que sea un usuario perteneciente
    # a la plataforma, porque al publicar plugin se pueden crear tags.
    return true
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
