require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do


  before(:each) do
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
      get :show, params: FactoryGirl.create(:category).attributes
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
        post :create, params: { category: FactoryGirl.build(:category, shortname: "aaa-2 a s").attributes }
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
        put :update, params: { id: category.id, category: { shortname: "test-test-test        "} }
        expect(category.name).to eq(name)
        category.reload
        expect(category.shortname).to eq("test-test-test")
      end

      it "renders a JSON response with the category" do
        category = FactoryGirl.create(:category)
        put :update, params: { id: category.id, category: { shortname: "  x-texxxxxxx"} }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the category" do
        category = FactoryGirl.create(:category)
        shortname = category.shortname
        put :update, params: { id: category.id, category: { shortname: "  x-texxx xxxx"} }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
        category.reload
        expect(category.shortname).to eq(shortname)
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
