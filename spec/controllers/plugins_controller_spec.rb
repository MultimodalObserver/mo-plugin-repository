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

  describe "POST #add_tag" do
    user = login_as FactoryGirl.create(:user)

    it "doesn't add duplicate associations" do

      tag = FactoryGirl.create(:tag)
      plugin = FactoryGirl.create(:plugin, user: user)

      expect{
        post :add_tag, params: { id: plugin.id, tag_name: "abcdef" }
      }.to change(Plugin, :count).by 0      

      expect{
        post :add_tag, params: { id: plugin.id, tag_name: "abcdef" }
      }.to raise_error ActiveRecord::RecordNotUnique

      expect{
        post :add_tag, params: { id: plugin.id, tag_name: "  abcdef" }
      }.to raise_error ActiveRecord::RecordInvalid


    end
  end

  describe "GET #search" do

    it "returns search results" do

      FactoryGirl.create(:plugin, name: "xhello")
      FactoryGirl.create(:plugin, name: "hello")
      FactoryGirl.create(:plugin, name: "hellooo")
      FactoryGirl.create(:plugin, name: "hell")
      FactoryGirl.create(:plugin, name: "helllll")
      FactoryGirl.create(:plugin, name: "helloooooo")

      get :index, params: { q: "he" }
      expect(response).to be_success
      parsed = JSON.parse response.body
      expect(parsed.length).to eq 3
      expect(parsed[0]["name"]).to eq "hello"
      expect(parsed[1]["name"]).to eq "hellooo"
      expect(parsed[2]["name"]).to eq "hell"

      get :index, params: { q: "he", limit: 15 }
      expect(response).to be_success
      parsed = JSON.parse response.body
      expect(parsed.length).to eq 5
      expect(parsed[0]["name"]).to eq "hello"
      expect(parsed[1]["name"]).to eq "hellooo"
      expect(parsed[2]["name"]).to eq "hell"
      expect(parsed[3]["name"]).to eq "helllll"
      expect(parsed[4]["name"]).to eq "helloooooo"

      get :index, params: { q: "he" }
      expect(response).to be_success
      parsed = JSON.parse response.body
      expect(parsed.length).to eq 3
      expect(parsed[0]["name"]).to eq "hello"
      expect(parsed[1]["name"]).to eq "hellooo"
      expect(parsed[2]["name"]).to eq "hell"

      get :index, params: { q: "Hello", limit: 15 }
      expect(response).to be_success
      parsed = JSON.parse response.body
      expect(parsed.length).to eq 3
      expect(parsed[0]["name"]).to eq "hello"
      expect(parsed[1]["name"]).to eq "hellooo"
      expect(parsed[2]["name"]).to eq "helloooooo"

      get :index, params: { q: "Hello", limit: 2 }
      expect(response).to be_success
      parsed = JSON.parse response.body
      expect(parsed.length).to eq 2
      expect(parsed[0]["name"]).to eq "hello"
      expect(parsed[1]["name"]).to eq "hellooo"

      get :index, params: { q: "X", limit: 2 }
      expect(response).to be_success
      parsed = JSON.parse response.body
      expect(parsed.length).to eq 1
      expect(parsed[0]["name"]).to eq "xhello"

      get :index, params: { q: "bbbb", limit: 2 }
      expect(response).to be_success
      parsed = JSON.parse response.body
      expect(parsed.length).to eq 0
    end
  end


  describe "GET #filter_by_tag" do

    cat = FactoryGirl.create(:tag, :short_name => 'tAg-9999')
    empty_cat = FactoryGirl.create(:tag, :short_name => 'categORY-EmpTY')

    cat.plugins << FactoryGirl.create(:plugin)
    cat.plugins << FactoryGirl.create(:plugin)
    cat.plugins << FactoryGirl.create(:plugin)

    it "returns a success response" do
      get :filter_by_tag, params: { :tag_name => "tag-9999" }
      expect(response).to be_success
    end

    it "returns an array of plugins that belong to that tag (with correct pagination)" do
      get :filter_by_tag, params: { :tag_name => "tag-9999", :page => 1 }
      plugins = JSON.parse(response.body)
      expect(plugins.count).to eq 3

      get :filter_by_tag, params: { :tag_name => "tag-9999", :page => 2 }
      plugins = JSON.parse(response.body)
      expect(plugins.count).to eq 0
    end

    it "returns an empty array of plugins" do
      get :filter_by_tag, params: { :tag_name => "categORY-EmpTY" }
      plugins = JSON.parse(response.body)
      expect(plugins.count).to eq 0
    end

    it "returns an error because tag doesn't exist" do
      expect {
        get :filter_by_tag, params: { :tag_name => "I-DONT-EXIST" }
      }.to raise_error ActiveRecord::RecordNotFound
    end
  end



  describe "POST #plugin correctly authorized" do

    login_as_normal_user

    it "creates a new Plugin" do
      expect {
        post :create, params: { plugin: FactoryGirl.attributes_for(:plugin, :github) }
      }.to change(Plugin, :count).by(1)
      plugin = JSON.parse(response.body)
      expect(plugin["repo_type"]).to eq "github"
    end

    it "creates a new Plugin with a short-name that already exists (throws error)" do
      FactoryGirl.create(:plugin, :github, :short_name => ' short-name-already-EXISTS  ')
      expect {
        post :create, params: { plugin: FactoryGirl.attributes_for(:plugin, :github, :short_name => ' short-NAME-Already-exists  ') }
      }.to change(Plugin, :count).by(0)
      expect(response).to have_http_status :unprocessable_entity
    end

    it "creates a new Plugin without repository (throws error)" do
      expect {
        attr = FactoryGirl.attributes_for(:plugin, :github)
        attr.delete :repo_type # Remove repository type
        post :create, params: { plugin: attr }
      }.to change(Plugin, :count).by(0)
      expect(response).to have_http_status :unprocessable_entity
    end

    it "throws an error if params are invalid" do
      post :create, params: { plugin: FactoryGirl.attributes_for(:plugin, :github, :short_name => '$50') }
      expect(response).to have_http_status :unprocessable_entity

      post :create, params: { plugin: FactoryGirl.attributes_for(:plugin, :github, :short_name => '503%') }
      expect(response).to have_http_status :unprocessable_entity

      post :create, params: { plugin: FactoryGirl.attributes_for(:plugin, :github, :short_name => ' 55 ', :name => '   ') }
      expect(response).to have_http_status :unprocessable_entity
    end
  end


  describe "POST #plugin unauthorized (banned user)" do
    login_as FactoryGirl.create(:user, :banned)
    it "creates a new Plugin (gets Unauthorized error)" do
      post :create, params: { plugin: FactoryGirl.attributes_for(:plugin, :github) }
      expect(response).to have_http_status :unauthorized
    end
  end

  describe "POST #plugin unauthorized (without login)" do
    it "creates a new Plugin (gets Unauthorized error)" do
      post :create, params: { plugin: FactoryGirl.attributes_for(:plugin, :github) }
      expect(response).to have_http_status :unauthorized
    end
  end


  describe "PUT #plugin" do
    user = login_as FactoryGirl.create(:user)
    it "updates correctly" do
      post :create, params: { plugin: FactoryGirl.attributes_for(:plugin, :github, :repo_name => "the-repo-namE  ") }
      plugin_id = JSON.parse(response.body)["id"]
      new_plugin = { :repo_type => :github, :name => "updated   name", :short_name => "  hehehe" }

      put :update, params: { id: plugin_id, plugin: new_plugin }
      expect(response).to have_http_status :ok
      updated = Plugin.find(plugin_id)
      expect(updated.name).to eq 'updated name'
      expect(updated.short_name).to eq 'hehehe'
      expect(updated.repo_type).to eq 'github'
      expect(updated.repo_name).to eq 'the-repo-name'
    end

    it "doesn't update user_id (plugins can't be transferred from one user to another)" do

      post :create, params: { plugin: FactoryGirl.attributes_for(:plugin, :github, :repo_name => 'xxxxxqqwweert') }

      plugin_id = JSON.parse(response.body)["id"]
      plugin_user_id = JSON.parse(response.body)["user_id"]
      expect(plugin_user_id).to eq user.id

      new_user = FactoryGirl.create(:user)

      put :update, params: {
        id: plugin_id,
        plugin: {
          user_id: new_user.id,
          user: new_user,
          repo_name: 'new-repo-name-software'
        }
      }
      expect(response).to have_http_status :ok
      updated = Plugin.find(plugin_id)
      expect(updated.user_id).to eq user.id # User id remains the same
      expect(updated.repo_name).to eq 'new-repo-name-software'
    end

    it "can't be updated if it's not a plugin owned by the logged in user" do
      plugin = FactoryGirl.create :plugin, :github
      put :update, params: { id: plugin.id, plugin: { repo_name: 'new-repo-name-software' } }
      expect(response).to have_http_status :unauthorized
    end
  end


  describe "DELETE #plugin" do
    user = login_as FactoryGirl.create(:user)
    it "destroys correctly" do
      post :create, params: { plugin: FactoryGirl.attributes_for(:plugin, :github, :repo_name => "the-repo-namE  ") }
      plugin_id = JSON.parse(response.body)["id"]
      expect {
        delete :destroy, params: { id: plugin_id }
      }.to change(Plugin, :count).by(-1)
      expect(response).to have_http_status :no_content
    end

    it "can't delete another user's plugin" do
      plugin = FactoryGirl.create(:plugin, :github)
      delete :destroy, params: { id: plugin.id }
      expect(response).to have_http_status :unauthorized
    end

    it "can't be updated if it's not a plugin owned by the logged in user" do
      plugin = FactoryGirl.create :plugin, :github
      put :update, params: { id: plugin.id, plugin: { repo_name: 'new-repo-name-software' } }
      expect(response).to have_http_status :unauthorized
    end
  end



end
