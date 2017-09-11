require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do


  before(:all) do
    FactoryGirl.create(:category)
    FactoryGirl.create(:category)
    FactoryGirl.create(:category)
    FactoryGirl.create(:category)
  end


  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_success
    end
  end


  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { :category_name => "short-name1" }
      expect(response).to be_success
    end
  end



  describe "POST #create" do

    login_as_admin

    it "creates a new Category" do
      expect {
        post :create, params: { category: FactoryGirl.build(:category).attributes }
      }.to change(Category, :count).by(1)
    end

    it "creates a category that already exists" do
      FactoryGirl.create(:category, short_name: " VeRy-beautifuL-category   ")
      post :create, params: { category: FactoryGirl.attributes_for(:category, short_name: "   very-BEAUTIFUL-categorY   ") }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    context "with valid params" do

      it "renders a JSON response with the new category" do
        post :create, params: { category: FactoryGirl.build(:category).attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(category_url(Category.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new category" do
        post :create, params: { category: FactoryGirl.build(:category, short_name: "aaa-2 a s").attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end


  describe "Unauthorized" do
    login_as_moderator

    it "cannot create" do
      post :create, params: {}
      expect(response).to have_http_status(:unauthorized)
    end
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

      it "updates the requested category" do
        category = FactoryGirl.create(:category)
        name = category.name
        put :update, params: { id: category.id, category: { short_name: "test-test-test        "} }
        expect(category.name).to eq(name)
        category.reload
        expect(category.short_name).to eq("test-test-test")
      end

      it "renders a JSON response with the category" do
        category = FactoryGirl.create(:category)
        put :update, params: { id: category.id, category: { short_name: "  x-texxxxxxx"} }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the category" do
        category = FactoryGirl.create(:category)
        short_name = category.short_name
        put :update, params: { id: category.id, category: { short_name: "  x-texxx xxxx"} }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
        category.reload
        expect(category.short_name).to eq(short_name)
      end
    end


    context "updating and setting short-name to something that already exists" do
      it "throws error" do
        FactoryGirl.create(:category, :short_name => " alReady-exISts   ")
        category = FactoryGirl.create(:category, :short_name => 'old-NAME  ')
        put :update, params: { id: category.id, category: { short_name: "  already-EXISTS "} }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
        category.reload
        expect(category.short_name).to eq('old-name')
      end
    end


  end


  describe "DELETE #destroy" do

    login_as_admin

    it "destroys the requested category" do
      category = FactoryGirl.create(:category)
      expect {
        delete :destroy, params: { id: category.id }
      }.to change(Category, :count).by(-1)
    end
  end

end
