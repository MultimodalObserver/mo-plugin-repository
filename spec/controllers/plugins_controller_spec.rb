require 'rails_helper'
require 'json'

RSpec.describe PluginsController, type: :controller do


  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_success
    end
  end


  describe "GET #show" do

    FactoryGirl.create(:plugin, :short_name => 'short-NAME-12345')
    it "returns a success response" do
      get :show, params: { :plugin_name => "short-name-12345" }
      expect(response).to be_success
    end
  end


  describe "GET #filter_by_category" do

    cat = FactoryGirl.create(:category, :short_name => 'categORY-9999')
    empty_cat = FactoryGirl.create(:category, :short_name => 'categORY-EmpTY')

    cat.plugins << FactoryGirl.create(:plugin)
    cat.plugins << FactoryGirl.create(:plugin)
    cat.plugins << FactoryGirl.create(:plugin)

    it "returns a success response" do
      get :filter_by_category, params: { :category_name => "category-9999" }
      expect(response).to be_success
    end

    it "returns an array of plugins that belong to that category (with correct pagination)" do
      get :filter_by_category, params: { :category_name => "category-9999", :page => 1 }
      plugins = JSON.parse(response.body)
      expect(plugins.count).to eq 3

      get :filter_by_category, params: { :category_name => "category-9999", :page => 2 }
      plugins = JSON.parse(response.body)
      expect(plugins.count).to eq 0
    end

    it "returns an empty array of plugins" do
      get :filter_by_category, params: { :category_name => "categORY-EmpTY" }
      plugins = JSON.parse(response.body)
      expect(plugins.count).to eq 0
    end

    it "returns an error because category doesn't exist" do
      expect {
        get :filter_by_category, params: { :category_name => "I-DONT-EXIST" }
      }.to raise_error ActiveRecord::RecordNotFound
    end

  end



end
