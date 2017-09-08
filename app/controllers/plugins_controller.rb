class PluginsController < ApplicationController

  def index
    plugins = Plugin.paginate(:page => params[:page], :per_page => 10)
    render json: plugins.to_json(:only => [:name, :description, :repository_url, :home_page])
  end

end
