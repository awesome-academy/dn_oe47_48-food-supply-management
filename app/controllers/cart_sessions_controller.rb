class CartSessionsController < ApplicationController
  before_action :check_quantity, only: :create

  def create
    sp_create
    load_products
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
      redirect_to root_path
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
    redirect_to root_path
  end

  def check_sum
    sum = current_cart[params[:product_id].to_s].to_f + @quantity
    @product.quantity < sum
  end
end
