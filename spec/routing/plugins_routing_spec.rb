require "rails_helper"

RSpec.describe PluginsController, type: :routing do
  describe "routing" do

    it "routes to #explore" do
      expect(:get => "/plugins").to route_to("plugins#explore")
    end

    it "routes to #show" do
      expect(:get => "/plugins/short-name-plugin").to route_to("plugins#show", :plugin_name => "short-name-plugin")
    end
=begin
    it "routes to #create" do
      expect(:post => "/plugins").to route_to("plugins#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/plugins/1").to route_to("plugins#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/plugins/1").to route_to("plugins#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/plugins/1").to route_to("plugins#destroy", :id => "1")
    end
=end

  end
end
