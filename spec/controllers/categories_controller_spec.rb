require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do


  let(:user) { FactoryGirl.create(:current_user1) }


  # RSpec version >= 3 syntax:
  before { allow(controller).to receive(:current_user) { user } }



  describe "GET #index" do
    it "returns a success response" do
      #allow(@controller).to receive(:current_user) { user }
      get :index
      expect(response).to be_success
    end
  end

=begin
  describe "GET #show" do
    it "returns a success response" do
      get :show, params: FactoryGirl.build(:valid_category1).attributes
      expect(response).to be_success
    end
  end



  describe "POST #create" do

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
=begin
  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested category" do
        category = Category.create! valid_attributes
        put :update, params: {id: category.to_param, category: new_attributes}, session: valid_session
        category.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the category" do
        category = Category.create! valid_attributes

        put :update, params: {id: category.to_param, category: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the category" do
        category = Category.create! valid_attributes

        put :update, params: {id: category.to_param, category: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested category" do
      category = Category.create! valid_attributes
      expect {
        delete :destroy, params: {id: category.to_param}, session: valid_session
      }.to change(Category, :count).by(-1)
    end
  end

=end
end
