class OrdersController < ApplicationController
  include ApplicationHelper

  before_action :logged_in_user, :cart_exist?, only: %i(new create)

  def create
    ActiveRecord::Base.transaction do
      handle_order
      session[:cart] = {}
    end
    flash[:success] = t :order_success
    redirect_to root_path
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = t :order_success
    redirect_to cart_path
  end

  def build_cart_detail ids
    ids.each do |product|
      sp_product = Product.find_by(id: product)
      item = {product_id: product,
              quantity: current_cart[product.to_s],
              price: sp_product.price}
      @order.order_products.build item
      sp_product.handle_update_quantity(current_cart[product.to_s])
    end
  end

  def cart_exist?
    return if session_cart_exist?

    flash[:warning] = t :cart_empty
    redirect_to cart_sessions_path
  end

  def handle_order
    @order = current_user.orders.build
    build_cart_detail current_cart.keys.sort
    @order.total = into_money_cart
    @order.address = current_user
                     .town.district.name + "-" + current_user.town.name
    @order.save!
  end
end
