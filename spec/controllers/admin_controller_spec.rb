require 'rails_helper'

RSpec.describe AdminController, type: :controller do


  describe "POST #accept_plugin and #reject_plugin" do
    login_as_admin

    it "accepts plugin correctly" do
      p = FactoryGirl.create(:plugin, :status => "pending")
      expect(p.status).to eq "pending"
      post :accept_plugin, params: { id: p.id }
      expect(response).to have_http_status :ok
      p.reload
      expect(p.status).to eq "confirmed"
    end

    it "rejects plugin correctly" do
      p = FactoryGirl.create(:plugin, :status => "pending")
      expect(p.status).to eq "pending"
      post :reject_plugin, params: { id: p.id }
      expect(response).to have_http_status :ok
      p.reload
      expect(p.status).to eq "rejected"
    end

  end

end
