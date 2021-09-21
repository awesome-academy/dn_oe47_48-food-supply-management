class Admin::ProductsController < Admin::AdminsController
  def index
    @products = Product.page(params[:page])
                       .per(Settings.per_page.per_5)
    respond_to do |format|
      format.html{redirect_to admin_root_path}
      format.js
    end
  end
end
