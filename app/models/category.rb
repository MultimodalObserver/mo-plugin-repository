class Category < ActiveRecord::Base

  validates :name, presence: true
  validates :shortname, presence: true
  validates :shortname, format: { with: /\A[a-zA-Z-]+\z/, message: "Only a-z A-Z and dash." }

  auto_strip_attributes :name, :squish => true
  auto_strip_attributes :shortname, :squish => true

end
