class Plugin < ActiveRecord::Base

  belongs_to :user

  auto_strip_attributes :name, :squish => true
  auto_strip_attributes :short_name
  auto_strip_attributes :repo_type
  auto_strip_attributes :repo_user
  auto_strip_attributes :repo_name
  auto_strip_attributes :home_page
  auto_strip_attributes :description, :squish => true

  validates :name, presence: true
  validates :short_name, presence: true, uniqueness: true
  validates :short_name, format: { with: /\A[a-z0-9-]+\z/, message: "Only a-z A-Z and dash." }

  enum repo_type: [ :github, :bitbucket ]
  validates :repo_user, presence: true
  validates :repo_name, presence: true

  validates :user_id, presence: true

  has_and_belongs_to_many :categories

  before_validation :downcase_fields


  def downcase_fields
    self.short_name.downcase! if !self.short_name.nil?
    self.repo_type.downcase! if !self.repo_type.nil?
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
