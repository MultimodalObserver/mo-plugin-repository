class HomeController < ApplicationController
  def index

    render json: {
      :mo_plugin_repository => true,
      :api_version => 1.1
    }

  end
end
