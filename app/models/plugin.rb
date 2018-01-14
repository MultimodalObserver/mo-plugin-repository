class Plugin < ActiveRecord::Base

  include PgSearch

  pg_search_scope :search, :against => [:description, :name, :short_name, :repo_name, :repo_user]

  belongs_to :user

  auto_strip_attributes :name, :squish => true
  auto_strip_attributes :short_name
  auto_strip_attributes :repo_type
  auto_strip_attributes :repo_user
  auto_strip_attributes :repo_name
  auto_strip_attributes :home_page
  auto_strip_attributes :description, :squish => true

  validates :name, presence: true
  validates_length_of :name, :minimum => 1, :maximum => 75, :allow_blank => false
  validates :short_name, presence: true, uniqueness: { message: "Slug has already been taken, please choose another one." }
  validates :short_name, format: { with: /\A[a-z0-9-]+\z/, message: "Only a-z A-Z, numbers and dashes are allowed." }

  validates_length_of :home_page, :maximum => 75, :allow_blank => true
  validates_length_of :repo_name, :maximum => 75, :allow_blank => false
  validates_length_of :repo_user, :maximum => 75, :allow_blank => false
  validates_length_of :short_name, :maximum => 75, :allow_blank => false
  validates_length_of :description, :maximum => 1048576, :allow_blank => true

  #enum repo_type: [ :github, :bitbucket ]
  enum repo_type: [ :github ]
  validates :repo_user, presence: true
  validates :repo_name, presence: true
  validates :repo_type, presence: true

  validates :user_id, presence: true

  has_and_belongs_to_many :tags

  before_validation :downcase_fields

  enum status: [ :pending, :rejected, :confirmed ]


  def downcase_fields
    self.short_name.downcase! if !self.short_name.nil?
    self.repo_type.downcase! if !self.repo_type.nil?
    self.repo_name.downcase! if !self.repo_name.nil?
    self.repo_user.downcase! if !self.repo_user.nil?
    self.home_page.downcase! if !self.home_page.nil?
  end


  def self.split_repository_data(repository_url)

    simple_url = SimpleUrl.new repository_url, 'HTTPS'

    # Only Bitbucket and Github

    return {
      repo_type: simple_url.guess_host,
      repo_user: simple_url.path_array[0],
      repo_name: simple_url.path_array[1]
    }

  end


end
