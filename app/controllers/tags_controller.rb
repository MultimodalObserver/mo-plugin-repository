class TagsController < ApplicationController

  before_action :set_tag, only: [:update, :destroy]
  before_action :authenticate_user!, only: [:create, :update, :destroy]


  # GET /tags
  def index
    tags = Tag.all
    render json: tags, :except => [:created_at, :updated_at]
  end

  # GET /tags/1
  def show

    tag = Tag.limit(1).find_by(:short_name => params[:tag_name].downcase)

    raise ActiveRecord::RecordNotFound if tag.nil?

    render json: tag if !tag.nil?
  end



  # POST /tags
  def create
    authorize Tag
    tag = Tag.new(tag_params)

    if tag.save
      render json: tag, status: :created, location: tag
    else
      render json: tag.errors, status: :unprocessable_entity
    end
  end



  # PATCH/PUT /tags/1
  def update

    authorize Tag

    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  def destroy
    authorize Tag
    @tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.fetch(:tag).permit(:name, :short_name)
    end
end
