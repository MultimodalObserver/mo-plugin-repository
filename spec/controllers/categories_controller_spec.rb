require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do


  before(:each) do

    FactoryGirl.create(:valid_category1)
    FactoryGirl.create(:valid_category2)
    FactoryGirl.create(:valid_category3)
    FactoryGirl.create(:valid_category4)

  end


  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_success
    end
  end


  describe "GET #show" do
    it "returns a success response" do
      get :show, params: FactoryGirl.build(:valid_category1).attributes
      expect(response).to be_success
    end
  end



  describe "POST #create" do

    login_as(FactoryGirl.build(:current_user1))

    it "creates a new Category" do
      expect {
        post :create, params: { category: FactoryGirl.build(:valid_category4).attributes }
      }.to change(Category, :count).by(1)
    end

    context "with valid params" do

      it "renders a JSON response with the new category" do
        post :create, params: { category: FactoryGirl.build(:valid_category5).attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(category_url(Category.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new category" do
        post :create, params: { category: FactoryGirl.build(:invalid_category1).attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end

    end
  end

  describe "PUT #update" do

    login_as(FactoryGirl.build(:current_user1))

    context "with valid params" do

      it "updates the requested category" do
        category = FactoryGirl.build(:valid_category4)
        name = category.name
        put :update, params: { id: category.id, category: { shortname: "test-test-test        "} }
        expect(category.name).to eq(name)
        category.reload
        expect(category.shortname).to eq("test-test-tests")
      end

      it "renders a JSON response with the category" do
        category = FactoryGirl.build(:valid_category3)
        put :update, params: { id: category.id, category: { shortname: "  x-texxxxxxx"} }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the category" do
        category = FactoryGirl.build(:valid_category2)
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
    login_as(FactoryGirl.build(:current_user1))
    it "destroys the requested category" do
      category = FactoryGirl.build(:valid_category1)
      expect {
        delete :destroy, params: { id: category.id }
      }.to change(Category, :count).by(-1)
    end
  end

end
