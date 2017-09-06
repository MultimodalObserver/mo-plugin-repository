require 'rails_helper'

RSpec.describe Link, :type => :model do


  it "is valid with a valid URL format" do
    user = FactoryGirl.create(:user1)

    FactoryGirl.build(:valid_urls).each_with_index do |url, i|
      user.links << Link.new({ id: i + 1, url: url, user_id: user.id })
    end

    user.links.each do |link|
      expect(link).to be_valid
    end
  end



  it "has an invalid URL format" do
    user = FactoryGirl.create(:user1)

    FactoryGirl.build(:invalid_urls).each_with_index do |url, i|
      user.links << Link.new({ id: i + 1, url: url, user_id: user.id })
    end

    user.links.each do |link|
      expect(link).to_not be_valid
    end
  end

end
