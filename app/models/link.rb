require 'uri'

class Link < ActiveRecord::Base

  auto_strip_attributes :url

  validates :url, presence: true
  validates :user_id, presence: true

  belongs_to :user

  def try_get_host
    su = SimpleUrl.new url
    su.guess_host
  end

end
