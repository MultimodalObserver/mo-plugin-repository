require 'rails_helper'

RSpec.describe SimpleUrl, :type => :concern do


  it "is divided correctly" do
    user = FactoryGirl.create(:user1)

    urls = FactoryGirl.build(:simple_urls)

    urls.each do |url|
      su = SimpleUrl.new url[0]
      expect(su.full_url).to eq url[0]
      expect(su.scheme).to eq url[1]
      expect(su.guess_host).to eq url[2]
    end
  end
end
