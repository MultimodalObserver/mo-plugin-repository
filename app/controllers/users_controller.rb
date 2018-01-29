class UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy, :change_status, :change_role]
  before_action :authenticate_user!, only: [:me, :my_plugins]

  def index
    users = User.all
    render json: users.to_json(only: [:email, :auth_token])
  end

  def show
    render json: @user
  end

=begin
  def update
    authorize User
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
=end

  def change_username
    current_user.nickname = params[:new_username]
    if current_user.save
      render json: current_user, status: :ok
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end


  def me
    render json: current_user
  end

  def my_plugins
    plugins = Plugin.includes(:tags).where(user_id: current_user.id)
    render json: plugins.to_json({ :include => :tags }), status: :ok
  end

=begin
  def change_status
    authorize @user
    @user.status = params[:status]
    @user.save
    render json: @user, status: :ok
  end

  def change_role
    authorize @user
    @user.role = params[:role]
    @user.save
    render json: @user, status: :ok
  end
=end
private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.fetch(:user).permit(:email)
  end

end
