class HomeController < ApplicationController
  def index

    render json: {
      :mo_plugin_repository => true,
      :version => 1
    }

  end
end
