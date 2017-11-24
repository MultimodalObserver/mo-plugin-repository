class PluginsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_plugin, only: [:update, :remove_tag, :add_tag, :destroy]

  include Search

  def index

    if params.has_key?(:q) && params[:q].length > 0

      if !params.has_key?(:include_tags_search)
        get_search_results(params: params, model: Plugin, attribute: "name")
        return
      else
        get_mixed_search_results(params[:q])
        return
      end
    end

    plugins = Plugin.includes([:tags, :user]).order("id DESC").paginate(:page => params[:page], :per_page => 10)
    render_format_include_everything plugins
  end


  def filter_by_tag
    tag = Tag.select(:id).limit(1).find_by(:short_name => params[:tag_name].downcase)
    raise ActiveRecord::RecordNotFound if tag.nil?
    plugins = Plugin.joins(:tags).where(tags: { id: tag.id }).order("id DESC").paginate(:page => params[:page], :per_page => 10)
    render_format_include_everything plugins
  end


  def show
    plugin = Plugin.includes([:tags, :user]).limit(1).find_by(:short_name => params[:plugin_name].downcase)
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


  def remove_tag
    authorize @plugin
    tag = Tag.find(params[:tag_id])
    if @plugin.tags.delete(tag)
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  def add_tag
    authorize @plugin

    tag = Tag.find_by(short_name: params[:tag_name])

    if tag.nil?
      tag = Tag.new
      tag.name = params[:tag_name]
      tag.short_name = params[:tag_name]
      tag.save!
    end

    @plugin.tags << tag
    render json: tag.as_json, status: :ok

  end


  def update

    authorize @plugin

    # Can't change user!
    p = plugin_params
    p.delete :user_id
    p.delete :user

    if @plugin.update(p)
      render json: @plugin.to_json(:include => { :tags => {:only => [:id, :short_name]}})
    else
      render json: @plugin.errors, status: :unprocessable_entity
    end
  end


  def destroy
    authorize @plugin
    @plugin.destroy
  end

  private

  # This method must render search results by searching plugins
  # and plugins that belong to tags that are also searched.
  # In other words, it renders an array of plugins that come from
  # a mixed search (plugins that belong to the Plugin table and
  # plugins that belong to tags).
  #
  # This method's behavior could be done in other ways, but always keep in mind
  # that the purpose of this method is to simply search by a single query. It
  # could be implemented using full-text search, etc.
  #
  # The most basic implementation is to find plugins
  # by name (name%wildcard%) and to find tags also using a wildcard,
  # and then get some plugins that belong to that tag.
  def get_mixed_search_results(query)

    page = params[:page].to_i

    plugins = Plugin
    .where("lower(name) LIKE lower(?)", "#{query}%")
    .paginate(:page => page, :per_page => 10)
    .order('id DESC')

    plugins = [] if plugins.nil?

    tag = Tag.where("lower(short_name) LIKE lower(?)", "#{query}%").first

    if tag.nil?
      plugins2 = []
    else
      plugins2 = tag.plugins[(page-1)*10..(page * 10)-1]
      plugins2 = [] if plugins2.nil?
    end

    result = plugins | plugins2

    result.sort_by! { |p| -p.id }

    render_format_include_everything result

  end

  def render_format_include_everything(plugin)
    render json: plugin.to_json(
    :except => [:created_at, :updated_at],
    :include => { :user => {:only => [:nickname]}, :tags => {:only => [:id, :short_name]} }
  ), status: :ok
  end

  def set_plugin
    @plugin = Plugin.find(params[:id])
  end

  def plugin_params
    params.fetch(:plugin).permit(:name, :short_name, :repo_user, :repo_name, :repo_type, :description)
  end

end
