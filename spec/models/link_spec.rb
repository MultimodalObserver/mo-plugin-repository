require 'rails_helper'

RSpec.describe Link, :type => :model do


  it "is valid with a valid URL format" do
    user = FactoryGirl.create(:user)

    FactoryGirl.build(:valid_urls).each_with_index do |url, i|
      user.links << Link.new({ id: i + 1, url: url, user_id: user.id })
    end

    user.links.each do |link|
      expect(link).to be_valid
    end
  end



  it "has an invalid URL format" do
    user = FactoryGirl.create(:user)

    FactoryGirl.build(:invalid_urls).each_with_index do |url, i|
      user.links << Link.new({ id: i + 1, url: url, user_id: user.id })
    end

    user.links.each do |link|
      expect(link).to_not be_valid
    end
  end


  it "gets the correct host" do
    user = FactoryGirl.create(:user)

    user.links << Link.new({ id: 1, url: "http://www.GiThub.com", user_id: user.id })
    expect(user.links[0].try_get_host).to eq "github"

    user.links << Link.new({ id: 2, url: "http://www.faCeBook.org.jp", user_id: user.id })
    expect(user.links[1].try_get_host).to eq "facebook"


  end

end
