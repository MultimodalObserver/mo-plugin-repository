class Category < ActiveRecord::Base

  validates :name, presence: true
  validates :short_name, presence: true
  validates :short_name, format: { with: /\A[a-zA-Z0-9-]+\z/, message: "Only a-z A-Z and dash." }

  auto_strip_attributes :name, :squish => true
  auto_strip_attributes :short_name, :squish => true

  has_and_belongs_to_many :plugins

  before_save :downcase_fields

  def downcase_fields
    self.short_name.downcase!
  end

end
