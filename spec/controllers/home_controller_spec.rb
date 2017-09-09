require 'rails_helper'
require 'json'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    it "returns a success response" do
      get :index
      res = JSON.parse (response.body)

      expect(res["mo_plugin_repository"]).to be true
      expect(res.has_key? "api_version").to be true
    end
  end

end
