require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { :id => FactoryGirl.create(:user).attributes['id'] }
      expect(response).to be_success
    end
  end

=begin
  describe "PUT #change_status (authorization only). Normal user changes someone's status" do
    login_as FactoryGirl.build(:user)
    it "returns unauthorized" do
      put :change_status, params: { :id => FactoryGirl.create(:user).attributes['id'], :status => :banned }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PUT #change_status (authorization only). Moderator user changes someone's status" do

    moderator = login_as_moderator

    normal_user = FactoryGirl.create(:user, :normal_user)
    moderator_user = FactoryGirl.create(:user, :moderator)
    admin_user = FactoryGirl.create(:user, :admin)

    it "returns ok" do
      put :change_status, params: { :id => normal_user.id, :status => :active }
      expect(response).to have_http_status(:ok)
    end

    it "returns unauthorized (moderator -> self)" do
      put :change_status, params: { :id => moderator.id, :status => :active }
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns unauthorized (moderator -> moderator)" do
      put :change_status, params: { :id => moderator_user.id, :status => :active }
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns unauthorized (moderator -> admin)" do
      put :change_status, params: { :id => admin_user.id, :status => :active }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PUT #change_status (authorization only). Admin user changes someone's status" do

    admin = login_as_admin

    normal_user = FactoryGirl.create(:user, :normal_user)
    moderator_user = FactoryGirl.create(:user, :moderator)
    admin_user = FactoryGirl.create(:user, :admin)

    it "returns ok (admin -> self)" do
      put :change_status, params: { :id => admin.id, :status => :active }
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns ok (admin -> moderator)" do
      put :change_status, params: { :id => moderator_user.id, :status => :banned }
      expect(response).to have_http_status(:ok)
    end

    it "returns ok (admin -> normal_user)" do
      put :change_status, params: { :id => normal_user.id, :status => :banned }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT #change_status. Status changes correctly." do

    admin = login_as_admin

    it "returns ok (admin -> self)" do
      user = FactoryGirl.create(:user)
      expect(user.active?).to be true
      put :change_status, params: { :id => user.id, :status => :banned }
      user.reload
      expect(user.banned?).to be true
      put :change_status, params: { :id => user.id, :status => :active }
      user.reload
      expect(user.active?).to be true
    end
  end


  describe "PUT #change_role (authorization only)" do
    login_as_normal_user
    it "returns unauthorized" do
      put :change_role, params: { :id => FactoryGirl.create(:user).id, :role => :admin }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PUT #change_role (authorization only)" do
    login_as_moderator
    it "returns unauthorized" do
      put :change_role, params: { :id => FactoryGirl.create(:user).id, :role => :moderator }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PUT #change_role (authorization and behaviour)" do
    login_as_admin
    it "returns ok" do
      put :change_role, params: { :id => FactoryGirl.create(:user).id, :role => :normal_user }
      expect(response).to have_http_status(:ok)
    end

    it "returns unauthorized because an admin can't change another admin's permissions (role)" do
      put :change_role, params: { :id => FactoryGirl.create(:user, :admin).id, :role => :normal_user }
      expect(response).to have_http_status(:unauthorized)
    end

    it "changes role correctly" do
      user = FactoryGirl.create(:user, :normal_user)
      expect(user.normal_user?).to be true
      put :change_role, params: { :id => user.id, :role => :moderator }
      user.reload
      expect(user.moderator?).to be true
    end
  end
=end

=begin
  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: {user: valid_attributes}, session: valid_session
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do

        post :create, params: {user: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(user_url(User.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new user" do

        post :create, params: {user: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested user" do
        user = User.create! valid_attributes
        put :update, params: {id: user.to_param, user: new_attributes}, session: valid_session
        user.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the user" do
        user = User.create! valid_attributes

        put :update, params: {id: user.to_param, user: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the user" do
        user = User.create! valid_attributes

        put :update, params: {id: user.to_param, user: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete :destroy, params: {id: user.to_param}, session: valid_session
      }.to change(User, :count).by(-1)
    end
  end
=end
end
