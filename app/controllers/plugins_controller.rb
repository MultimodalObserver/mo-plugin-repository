class PluginsController < ApplicationController

  include Recaptcha::Verify

  include Search

  before_action :authenticate_user!, only: [:create, :update, :destroy]

  before_action :set_plugin, only: [:update, :remove_tag, :add_tag, :destroy]



  def explore

    if params.has_key?(:latest)
      return latest_plugins
    end

    query = Plugin

    if(search_query.length > 0)
      query = query.search(search_query)
    end

    query = query
    .where({ status: :confirmed })
    .paginate(:page => params[:page], :per_page => LIMIT)
    .includes([:tags, :user])
    .order("id DESC")

    render_format_include_everything query
  end




  def filter_by_tag
    tag = Tag.select(:id).limit(1).find_by(:short_name => params[:tag_name].downcase)

    raise ActiveRecord::RecordNotFound if tag.nil?
    plugins = Plugin
    .where({ status: :confirmed })
    .joins(:tags)
    .where(tags: { id: tag.id })
    .order("id DESC")
    .paginate(:page => params[:page], :per_page => LIMIT)

    render_format_include_everything plugins
  end


  def show
    plugin = Plugin
    .includes([:tags, :user])
    .limit(1)
    .find_by(:short_name => params[:plugin_name].downcase)

    if plugin.nil?
      # Plugin is null

    elsif plugin.status == "confirmed"
      # Plugin can be seen

    elsif !user_signed_in?
      plugin = nil

    elsif current_user.admin?
      # Plugin can be seen

    elsif plugin.user_id == current_user.id
      # Plugin can be seen

    else
      plugin = nil
    end

    raise ActiveRecord::RecordNotFound if plugin.nil?
    render_format_include_everything plugin
  end

  # POST /plugins
  def create

    authorize Plugin

    plugin = Plugin.new(plugin_params)
    plugin.user_id = current_user.id

    ActiveRecord::Base.transaction do

      if plugin_params.has_key?(:repo_type) && plugin.valid? && verify_recaptcha(model: plugin) && plugin.save
        render json: plugin, status: :created
      else
        render json: plugin.errors, status: :unprocessable_entity
      end

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
