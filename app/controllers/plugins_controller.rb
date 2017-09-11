class PluginsController < ApplicationController

  before_action :authenticate_user!, only: [:create]

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

  # POST /plugins
  def create
    authorize Plugin
    plugin = Plugin.new(plugin_params)
    plugin.user_id = current_user.id

    if plugin_params.has_key?(:repo_type) && plugin.save
      render json: plugin, status: :created
    else
      render json: plugin.errors, status: :unprocessable_entity
    end
  end

  private

  def render_format_include_everything(plugin)
    render json: plugin.to_json(
    :except => [:created_at, :updated_at],
    :include => { :categories => {:only => [:id, :short_name]}}
    )
  end

  def plugin_params
    params.fetch(:plugin).permit(:name, :short_name, :user_id, :repo_user, :repo_name, :repo_type)
  end

end
