class CategoriesController < ApplicationController

  before_action :set_category, only: [:update, :destroy]
  before_action :authenticate_user!, only: [:create, :update, :destroy]


  # GET /categories
  def index
    categories = Category.all
    render json: categories, :except => [:created_at, :updated_at]
  end

  # GET /categories/1
  def show

    category = Category.limit(1).find_by(:short_name => params[:category_name].downcase)

    raise ActiveRecord::RecordNotFound if category.nil?

    render json: category if !category.nil?
  end



  def plugins
    category = Category.select(:id).limit(1).find_by(:short_name => params[:category_name].downcase)
    raise ActiveRecord::RecordNotFound if category.nil?

    plugins = Plugin.joins(:categories).where(categories: { id: category.id }).order("id DESC").paginate(:page => params[:page], :per_page => 10)

    render json: plugins.to_json(:methods => :repository_data), :except => [:created_at, :updated_at]
  end



  # POST /categories
  def create
    authorize Category
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end



  # PATCH/PUT /categories/1
  def update

    authorize Category

    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    authorize Category
    @category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.fetch(:category).permit(:name, :short_name)
    end
end
