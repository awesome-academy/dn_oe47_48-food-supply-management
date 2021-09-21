class Admin::OrdersController < Admin::AdminsController
  def index
    @orders = Order.includes(order_products: :product)
                   .order_by_status.page(params[:page])
                   .per(Settings.per_page.per_5)
    respond_to do |format|
      format.html{redirect_to admin_root_path}
      format.js
    end
  end
end
