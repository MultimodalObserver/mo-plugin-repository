require "rails_helper"

RSpec.describe TagsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/tags").to route_to("tags#index")
    end

    it "routes to #show" do
      expect(:get => "/tags/short-name").to route_to("tags#show", :tag_name => "short-name")
    end

    it "routes to plugins#filter_by_tag" do
      expect(:get => "/tags/tag-short-name/plugins").to route_to("plugins#filter_by_tag", :tag_name => "tag-short-name")
    end

  end
end
