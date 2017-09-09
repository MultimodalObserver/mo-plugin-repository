class Category < ActiveRecord::Base

  validates :name, presence: true
  validates :short_name, presence: true
  validates :short_name, format: { with: /\A[a-z0-9-]+\z/, message: "Only a-z and dash." }

  auto_strip_attributes :name, :squish => true
  auto_strip_attributes :short_name, :squish => true

  has_and_belongs_to_many :plugins

  before_validation :downcase_fields

  def downcase_fields
    self.short_name.downcase! if !self.short_name.nil?
  end

end
