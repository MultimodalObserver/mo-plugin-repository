class PluginsController < ApplicationController

  def index
    plugins = Plugin.includes(:categories).order("id DESC").paginate(:page => params[:page], :per_page => 10)
    render_format_include_everything plugins

  end


  def filter_by_category
    category = Category.select(:id).limit(1).find_by(:short_name => params[:category_name].downcase)
    raise ActiveRecord::RecordNotFound if category.nil?

    plugins = Plugin.joins(:categories).where(categories: { id: category.id }).order("id DESC").paginate(:page => params[:page], :per_page => 10)

    render_format_include_everything plugins
  end



  def show
    plugin = Plugin.includes(:categories).limit(1).find_by(:short_name => params[:plugin_name].downcase)

    raise ActiveRecord::RecordNotFound if plugin.nil?

    render_format_include_everything plugin
  end

  private

  def render_format_include_everything(plugin)
    render json: plugin.to_json(
    :except => [:created_at, :updated_at],
    :include => { :categories => {:only => [:id, :short_name]}}
    )
  end

end
