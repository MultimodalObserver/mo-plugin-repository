require 'uri'

class Link < ApplicationRecord

  validates :url, presence: true

  belongs_to :user

  auto_strip_attributes :url

  def try_get_host
    su = SimpleUrl.new url
    su.guess_host
  end

end
