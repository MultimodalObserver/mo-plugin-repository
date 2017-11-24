class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable #, :confirmable

  include DeviseTokenAuth::Concerns::User

  has_many :links

  has_many :plugins

  enum status: [ :active, :banned ]

  enum role: [ :normal_user, :moderator, :admin ]

  validates :nickname, presence: true, uniqueness: true
  validates :nickname, format: { with: /\A[a-z0-9-]+\z/, message: "Only a-z, numbers and dash are allowed." }
  auto_strip_attributes :nickname, :squish => true

  validates :nickname, length: {
    maximum: 25,
    minimum: 2,
    too_long: "is too long, %{count} characters is the maximum allowed",
    too_short: "is too short, %{count} characters is the minimum allowed" }

  before_validation :downcase_fields

  def downcase_fields
    self.nickname.downcase! if !self.nickname.nil?
  end

  # Status

  def active?
    status.to_sym == :active
  end

  def banned?
    status.to_sym == :banned
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
