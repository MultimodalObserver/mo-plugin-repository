require 'uri'

class Link < ApplicationRecord

  validates :url, presence: true

  belongs_to :user

  auto_strip_attributes :url

end
