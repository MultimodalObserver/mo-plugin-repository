class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable #, :confirmable
          
  include DeviseTokenAuth::Concerns::User

  enum status: [ :ok, :banned, :deleted ]

  enum role: [ :normal, :moderator, :admin ]

end
