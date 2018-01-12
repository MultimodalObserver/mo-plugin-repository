require 'rails_helper'

RSpec.describe TagsController, type: :controller do


  before(:all) do
    FactoryGirl.create(:tag)
    FactoryGirl.create(:tag)
    FactoryGirl.create(:tag)
    FactoryGirl.create(:tag)
  end


  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_success
    end
  end


  describe "GET #show" do
    it "returns a success response" do
      FactoryGirl.create(:tag, :short_name => "Short-name1 ")
      get :show, params: { :tag_name => "short-name1" }
      expect(response).to be_success
    end
  end

  describe "GET #search" do

    it "returns search results" do

      FactoryGirl.create(:tag, short_name: "ahello")
      FactoryGirl.create(:tag, short_name: "hello")
      FactoryGirl.create(:tag, short_name: "hellooo")
      FactoryGirl.create(:tag, short_name: "hell")
      FactoryGirl.create(:tag, short_name: "helllll")
      FactoryGirl.create(:tag, short_name: "helloooooo")

      get :index, params: { q: "he" }
      expect(response).to be_success
      parsed = JSON.parse response.body
      expect(parsed.length).to eq 3
      expect(parsed[0]["short_name"]).to eq "hello"
      expect(parsed[1]["short_name"]).to eq "hellooo"
      expect(parsed[2]["short_name"]).to eq "hell"

      get :index, params: { q: "he", limit: 15 }
      expect(response).to be_success
      parsed = JSON.parse response.body
      expect(parsed.length).to eq 5
      expect(parsed[0]["short_name"]).to eq "hello"
      expect(parsed[1]["short_name"]).to eq "hellooo"
      expect(parsed[2]["short_name"]).to eq "hell"
      expect(parsed[3]["short_name"]).to eq "helllll"
      expect(parsed[4]["short_name"]).to eq "helloooooo"

      get :index, params: { q: "he" }
      expect(response).to be_success
      parsed = JSON.parse response.body
      expect(parsed.length).to eq 3
      expect(parsed[0]["short_name"]).to eq "hello"
      expect(parsed[1]["short_name"]).to eq "hellooo"
      expect(parsed[2]["short_name"]).to eq "hell"

      get :index, params: { q: "Hello", limit: 15 }
      expect(response).to be_success
      parsed = JSON.parse response.body
      expect(parsed.length).to eq 3
      expect(parsed[0]["short_name"]).to eq "hello"
      expect(parsed[1]["short_name"]).to eq "hellooo"
      expect(parsed[2]["short_name"]).to eq "helloooooo"

      get :index, params: { q: "Hello", limit: 2 }
      expect(response).to be_success
      parsed = JSON.parse response.body
      expect(parsed.length).to eq 2
      expect(parsed[0]["short_name"]).to eq "hello"
      expect(parsed[1]["short_name"]).to eq "hellooo"

      get :index, params: { q: "A", limit: 2 }
      expect(response).to be_success
      parsed = JSON.parse response.body
      expect(parsed.length).to eq 1
      expect(parsed[0]["short_name"]).to eq "ahello"
    end
  end

  describe "POST #create" do

    login_as_admin

    it "creates a new Tag" do
      expect {
        post :create, params: { tag: FactoryGirl.build(:tag).attributes }
      }.to change(Tag, :count).by(1)
    end

    it "creates a tag that already exists" do
      FactoryGirl.create(:tag, short_name: " VeRy-beautifuL-tag   ")
      post :create, params: { tag: FactoryGirl.attributes_for(:tag, short_name: "   very-BEAUTIFUL-tAG   ") }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    context "with valid params" do

      it "renders a JSON response with the new tag" do
        post :create, params: { tag: FactoryGirl.build(:tag).attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(tag_url(Tag.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new tag" do
        post :create, params: { tag: FactoryGirl.build(:tag, short_name: "aaa-2 a s").attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end


  describe "Unauthorized" do
    login_as_moderator
    it "cannot update" do
      put :update, params: { id: 2 }
      expect(response).to have_http_status(:unauthorized)
    end
    it "cannot destroy" do
      delete :destroy, params: { id: 2 }
      expect(response).to have_http_status(:unauthorized)
    end
  end



  describe "PUT #update" do

    login_as_admin

    context "with valid params" do

      it "updates the requested tag" do
        tag = FactoryGirl.create(:tag)
        put :update, params: { id: tag.id, tag: { short_name: "test-test-test        "} }
        tag.reload
        expect(tag.short_name).to eq("test-test-test")
      end

      it "renders a JSON response with the tag" do
        tag = FactoryGirl.create(:tag)
        put :update, params: { id: tag.id, tag: { short_name: "  x-texxxxxxx"} }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the tag" do
        tag = FactoryGirl.create(:tag)
        short_name = tag.short_name
        put :update, params: { id: tag.id, tag: { short_name: "  x-texxx xxxx"} }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
        tag.reload
        expect(tag.short_name).to eq(short_name)
      end
    end


    context "updating and setting short-name to something that already exists" do
      it "throws error" do
        FactoryGirl.create(:tag, :short_name => " alReady-exISts   ")
        tag = FactoryGirl.create(:tag, :short_name => 'old-NAME  ')
        put :update, params: { id: tag.id, tag: { short_name: "  already-EXISTS "} }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
        tag.reload
        expect(tag.short_name).to eq('old-name')
      end
    end


  end


  describe "DELETE #destroy" do

    login_as_admin

    it "destroys the requested tag" do
      tag = FactoryGirl.create(:tag)
      expect {
        delete :destroy, params: { id: tag.id }
      }.to change(Tag, :count).by(-1)
    end
  end

end
