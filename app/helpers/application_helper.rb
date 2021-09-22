module ApplicationHelper
  def full_title page_title = ""
    base_title = t "tittle_project"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def load_products
    @carts = Product.load_by_ids(current_cart.keys)
  end

  def into_money product
    (product.price * current_cart[product.id.to_s].to_f).round(3)
  end

  def current_cart
    @current_cart ||= session[:cart]
  end
end
