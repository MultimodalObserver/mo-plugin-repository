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

    it "routes to #create" do
      expect(:post => "/tags").to route_to("tags#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/tags/1").to route_to("tags#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/tags/1").to route_to("tags#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tags/1").to route_to("tags#destroy", :id => "1")
    end

  end
end
