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



  describe "POST #plugin correctly authorized" do

    login_as_normal_user

    it "creates a new Plugin" do
      expect {
        post :create, params: { plugin: FactoryGirl.attributes_for(:plugin, :bitbucket) }
      }.to change(Plugin, :count).by(1)
      plugin = JSON.parse(response.body)
      expect(plugin["repo_type"]).to eq "bitbucket"
    end

    it "creates a new Plugin with a short-name that already exists (throws error)" do
      FactoryGirl.create(:plugin, :bitbucket, :short_name => ' short-name-already-EXISTS  ')
      expect {
        post :create, params: { plugin: FactoryGirl.attributes_for(:plugin, :bitbucket, :short_name => ' short-NAME-Already-exists  ') }
      }.to change(Plugin, :count).by(0)
      expect(response).to have_http_status :unprocessable_entity
    end

    it "creates a new Plugin without repository (throws error)" do
      expect {
        attr = FactoryGirl.attributes_for(:plugin, :bitbucket)
        attr.delete :repo_type # Remove repository type
        post :create, params: { plugin: attr }
      }.to change(Plugin, :count).by(0)
      expect(response).to have_http_status :unprocessable_entity
    end

    it "throws an error if params are invalid" do
      post :create, params: { plugin: FactoryGirl.attributes_for(:plugin, :bitbucket, :short_name => '$50') }
      expect(response).to have_http_status :unprocessable_entity

      post :create, params: { plugin: FactoryGirl.attributes_for(:plugin, :bitbucket, :short_name => '503%') }
      expect(response).to have_http_status :unprocessable_entity

      post :create, params: { plugin: FactoryGirl.attributes_for(:plugin, :bitbucket, :short_name => ' 55 ', :name => '   ') }
      expect(response).to have_http_status :unprocessable_entity
    end
  end


  describe "POST #plugin unauthorized (banned user)" do
    login_as FactoryGirl.create(:user, :banned)
    it "creates a new Plugin (gets Unauthorized error)" do
      post :create, params: { plugin: FactoryGirl.attributes_for(:plugin, :bitbucket) }
      expect(response).to have_http_status :unauthorized
    end
  end

  describe "POST #plugin unauthorized (without login)" do
    it "creates a new Plugin (gets Unauthorized error)" do
      post :create, params: { plugin: FactoryGirl.attributes_for(:plugin, :bitbucket) }
      expect(response).to have_http_status :unauthorized
    end
  end


end
