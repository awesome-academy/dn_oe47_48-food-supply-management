class Admin::UsersController < Admin::AdminsController
  def index
    @users = User.buyer.order_by_name.page(params[:page])
                 .per(Settings.per_page.per_10)
    respond_to do |format|
      format.html{redirect_to admin_root_path}
      format.js
    end
  end
end
