class AdminController < ApplicationController

  before_action :authenticate_user!
  before_action :only_admin!
  before_action :set_plugin, only: [:accept_plugin, :reject_plugin]

  def get_pending_plugins

    plugins = Plugin
    .includes([:user])
    .limit(10)
    .where(status: :pending)
    .order("id DESC")

    if params.has_key?(:last_id)
      plugins = plugins.where("id < ?", params[:last_id].to_i)
    end

    render json: plugins.to_json(include: [:user]), status: :ok
  end

  def accept_plugin
    authorize Plugin
    @plugin.status = Plugin.statuses[:confirmed]
    @plugin.save!
    render json: { status: @plugin.status }, status: :ok
  end

  def reject_plugin
    authorize Plugin
    @plugin.status = Plugin.statuses[:rejected]
    @plugin.save!
    render json: { status: @plugin.status }, status: :ok
  end


  private


  def only_admin!
    raise Pundit::NotAuthorizedError if !user_signed_in? || !current_user.admin?
  end


  def set_plugin
    @plugin = Plugin.find(params[:id])
  end

end
