class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:me]

  def index
    users = User.all
    render json: users.to_json(only: [:email, :auth_token])
  end


  def me
    render json: current_user
  end

end
