require "rails_helper"

RSpec.describe CategoriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/categories").to route_to("categories#index")
    end

    it "routes to #show" do
      expect(:get => "/categories/short-name").to route_to("categories#show", :category_name => "short-name")
    end

    it "routes to plugins#filter_by_category" do
      expect(:get => "/categories/category-short-name/plugins").to route_to("plugins#filter_by_category", :category_name => "category-short-name")
    end

    it "routes to #create" do
      expect(:post => "/categories").to route_to("categories#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/categories/1").to route_to("categories#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/categories/1").to route_to("categories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/categories/1").to route_to("categories#destroy", :id => "1")
    end

  end
end
