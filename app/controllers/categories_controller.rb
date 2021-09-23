class CategoriesController < ApplicationController
  before_action :load_category, only: %i(show)

  def index
    @categories = Category.includes(:products).select(:name, :id)
    @products = Product.page(params[:page])
                       .per(Settings.length.pages_10)
  end

  def show
    @products = @category.products.page(params[:page])
                         .per(Settings.length.pages_10)
  end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category

    flash[:danger] = t "category.not_found"
    redirect_to root_path
  end
end
