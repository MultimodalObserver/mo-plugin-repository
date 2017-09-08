require 'rails_helper'

RSpec.describe SimpleUrl, :type => :concern do


  it "is partitioned correctly" do

    urls = FactoryGirl.build :simple_urls

    urls.each do |url|
      su = SimpleUrl.new url[0]
      expect(su.full_url).to eq url[0]
      expect(su.scheme).to eq url[1]
      expect(su.guess_host).to eq url[2]
    end
  end


  it "adds http correctly to URLs that don't have scheme (default scheme)" do

    urls = FactoryGirl.build :simple_urls_add_http

    urls.each do |url|

      su = SimpleUrl.new url[0]
      expect(su.full_url_default_scheme).to eq url[1]
    end
  end

  it "adds http correctly to URLs that don't have scheme (using a specified scheme)" do

    urls = FactoryGirl.build :simple_urls_add_custom_scheme

    urls.each do |url|
      su = SimpleUrl.new url[0], url[1]
      expect(su.full_url_default_scheme).to eq url[2]
    end
  end


  it "gets the path array correctly" do

    urls = FactoryGirl.build :simple_urls_path_array

    urls.each do |url|
      su = SimpleUrl.new url[0]
      expect(su.path_array).to eq url[1]
    end
  end



end
