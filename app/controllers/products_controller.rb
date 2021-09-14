class ProductsController < ApplicationController
  def show
    @product = Product.find_by id: params[:id]
    store_location
    return if @product

    flash[:danger] = t "product.not_found"
    redirect_to root_path
  end

  def search
    @products = Product.search_categories(params[:search])
                       .or(Product.search_products(params[:search]))
                       .distinct.page(params[:page])
                       .per(Settings.length.pages_10)
  end
end
