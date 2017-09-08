class Plugin < ApplicationRecord

  belongs_to :user

  auto_strip_attributes :repository_url
  auto_strip_attributes :home_page

  validates :repository_url, presence: true
  validates :user_id, presence: true


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

    return nil

  end

end
