class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable #, :confirmable

  include DeviseTokenAuth::Concerns::User

  enum status: [ :active, :banned, :deleted ]

  enum role: [ :normal_user, :moderator, :admin ]

  # Status

  def active?
    status.to_sym == :active
  end

  def banned?
    status.to_sym == :banned
  end

  def deleted?
    status.to_sym == :deleted
  end

  # Roles

  def normal_user?
    role.to_sym == :normal_user
  end

  def moderator?
    role.to_sym == :moderator
  end

  def admin?
    role.to_sym == :admin
  end



end
