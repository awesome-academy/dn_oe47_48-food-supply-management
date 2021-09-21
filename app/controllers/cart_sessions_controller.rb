class CartSessionsController < ApplicationController
  before_action :check_quantity, only: %i(create change remove)
  before_action :check_exist_product_id, only: %i(remove change)

  def index; end

  def change
    current_cart[params[:product_id].to_s] = params[:quantity].to_f
    flash.now[:success] = t "carts.update.success"
    @product_id = params[:product_id]
  end

  def remove
    current_cart.delete params[:product_id]
    flash.now[:success] = t "carts.delete.delete_success"
    @product_id = params[:product_id]
  end

  def create
    sp_create
    flash.now[:success] = t "carts.create.success"
  end

  private

  def cart_session_params
    params.require(:order_product).permit(:product_id, :quantity)
  end

  def check_quantity
    if @product = Product.find_by(id: params[:product_id])
      sp_check_quantity
    else
      flash[:danger] = t "carts.create.not_success"
      redirect_to cart_sessions_path
    end
  end

  def sp_create
    if !current_cart[params[:product_id].to_s]
      current_cart[params[:product_id].to_s] = @quantity
    else
      current_cart[params[:product_id].to_s] += @quantity
    end
  end

  def sp_check_quantity
    @quantity = params[:quantity].to_f
    return unless @quantity > @product.quantity.to_f || check_sum

    flash[:danger] = t "carts.create.not_success"
    redirect_to cart_sessions_path
  end

  def check_sum
    sum = current_cart[params[:product_id].to_s].to_f + @quantity
    @product.quantity < sum
  end

  def check_exist_product_id
    return if session[:cart][params[:product_id]]

    flash[:warning] = t "cart.update.not_exist_products"
    redirect_to cart_sessions_path
  end
end
