class Plugin < ActiveRecord::Base

  belongs_to :user

  auto_strip_attributes :name, :squish => true
  auto_strip_attributes :short_name, :squish => true
  auto_strip_attributes :repository_url
  auto_strip_attributes :home_page

  validates :name, presence: true
  validates :short_name, presence: true
  validates :short_name, format: { with: /\A[a-zA-Z0-9-]+\z/, message: "Only a-z A-Z and dash." }
  validates :repository_url, presence: true
  validates :user_id, presence: true

  has_and_belongs_to_many :categories

  before_save :downcase_fields

  def downcase_fields
    self.short_name.downcase!
  end


  def get_repository_data

    simple_url = SimpleUrl.new repository_url, 'HTTPS'

    # Using HTTPS github URL
    if simple_url.scheme == 'https' && (simple_url.guess_host == 'github' || simple_url.guess_host == 'bitbucket')

      return {
        repo_type: simple_url.guess_host,
        user_name: simple_url.path_array[0],
        repo_name: simple_url.path_array[1]
      }
    end

    return { }

  end

end
