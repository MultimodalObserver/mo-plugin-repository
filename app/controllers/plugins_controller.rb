require 'pp'

class PluginsController < ApplicationController

  def index

    plugins = Plugin.includes(:categories).paginate(:page => params[:page], :per_page => 10)

    render json: plugins,
    :include => { :categories => {:only => [:id, :short_name]}},
    :only => [:id, :name, :description, :repository_url, :home_page]
  end

  def show
    plugin = Plugin.includes(:categories).limit(1).find_by(:short_name => params[:plugin_name].downcase)

    raise ActiveRecord::RecordNotFound if plugin.nil?

    render json: plugin,
    :include => { :categories => {:only => [:id, :short_name]}},
    :only => [:id, :name, :description, :repository_url, :home_page] if !plugin.nil?
  end

end
