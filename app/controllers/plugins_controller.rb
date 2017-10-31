class PluginsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_plugin, only: [:update, :destroy]

  include Search

  def index

    if params.has_key? :q
      get_search_results(params: params, model: Plugin, attribute: "name")
      return
    end

    plugins = Plugin.includes(:tags).order("id DESC").paginate(:page => params[:page], :per_page => 10)
    render_format_include_everything plugins
  end


  def filter_by_tag
    tag = Tag.select(:id).limit(1).find_by(:short_name => params[:tag_name].downcase)
    raise ActiveRecord::RecordNotFound if tag.nil?
    plugins = Plugin.joins(:tags).where(tags: { id: tag.id }).order("id DESC").paginate(:page => params[:page], :per_page => 10)
    render_format_include_everything plugins
  end


  def show
    plugin = Plugin.includes(:tags).limit(1).find_by(:short_name => params[:plugin_name].downcase)
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


  def update

    authorize @plugin

    # Can't change user!
    p = plugin_params
    p.delete :user_id
    p.delete :user

    if @plugin.update(p)
      render json: @plugin
    else
      render json: @plugin.errors, status: :unprocessable_entity
    end
  end


  def destroy
    authorize @plugin
    @plugin.destroy
  end

  private

  def render_format_include_everything(plugin)
    render json: plugin.to_json(
    :except => [:created_at, :updated_at],
    :include => { :tags => {:only => [:id, :short_name]}}
    )
  end

  def set_plugin
    @plugin = Plugin.find(params[:id])
  end

  def plugin_params
    params.fetch(:plugin).permit(:name, :short_name, :repo_user, :repo_name, :repo_type)
  end

end
