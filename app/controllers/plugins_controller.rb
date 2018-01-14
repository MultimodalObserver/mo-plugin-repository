class PluginsController < ApplicationController

  include Recaptcha::Verify

  include Search

  before_action :authenticate_user!, only: [:create, :update, :destroy, :accept_plugin, :reject_plugin]

  before_action :set_plugin, only: [:update, :remove_tag, :add_tag, :destroy, :accept_plugin, :reject_plugin]



  def explore

    if params.has_key?(:latest)
      return latest_plugins
    end

    if params.has_key?(:q) && params[:q].length > 0

      if !params.has_key?(:include_tags_search)
        query = get_search_results(params: params, model: Plugin, attribute: "name")
        query = query.where({ status: :confirmed })
        render json: query, status: :ok
        return
      else
        get_mixed_search_results(params[:q])
        return
      end
    end

    plugins = Plugin
    .includes([:tags, :user])
    .where({ status: :confirmed })
    .order("id DESC")
    .paginate(:page => params[:page], :per_page => 10)

    render_format_include_everything plugins
  end




  def filter_by_tag
    tag = Tag.select(:id).limit(1).find_by(:short_name => params[:tag_name].downcase)

    limit = 3

    if(params.has_key?(:limit))
      limit = params[:limit].to_i
    end

    limit = 10 if limit > 10

    raise ActiveRecord::RecordNotFound if tag.nil?
    plugins = Plugin
    .where({ status: :confirmed })
    .joins(:tags)
    .where(tags: { id: tag.id })
    .order("id DESC")
    .paginate(:page => params[:page], :per_page => limit)

    render_format_include_everything plugins
  end


  def show
    plugin = Plugin
    .includes([:tags, :user])
    .limit(1)
    .find_by(:short_name => params[:plugin_name].downcase)

    if !plugin.nil? && plugin.status != "confirmed"

      if current_user.admin?
        # Don't nullify plugin
      else !user_signed_in? || plugin.user_id != current_user.id
        plugin = nil
      end
    end

    raise ActiveRecord::RecordNotFound if plugin.nil?
    render_format_include_everything plugin
  end

  # POST /plugins
  def create

    authorize Plugin

    plugin = Plugin.new(plugin_params)
    plugin.user_id = current_user.id


    if plugin_params.has_key?(:repo_type) && verify_recaptcha(model: plugin) && plugin.save
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
    p.delete :status

    if @plugin.update(p)
      render_format_include_everything @plugin
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
    .where({ status: :confirmed })
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

    if !user_signed_in? || !current_user.admin?
      plugins2.delete_if { |x| x.status != :confirmed }
    end


    result.sort_by! { |p| -p.id }

    render_format_include_everything result

  end

  def render_format_include_everything(plugin)
    render json: plugin.to_json(
    :except => [:created_at, :updated_at],
    :include => { :user => {:only => [:nickname]}, :tags => {:only => [:id, :short_name]} }
  ), status: :ok
  end

  def latest_plugins
    plugins = Plugin.where({ status: :confirmed }).limit(5).order("id DESC")
    render json: plugins.to_json(:only => [:name, :short_name])
  end


  def set_plugin
    @plugin = Plugin.find(params[:id])
  end

  def plugin_params
    params.fetch(:plugin).permit(:name, :short_name, :repo_user, :repo_name, :repo_type, :description)
  end

end
