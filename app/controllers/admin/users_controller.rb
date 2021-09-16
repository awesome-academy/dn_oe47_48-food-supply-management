class Admin::UsersController < Admin::AdminsController
  def index
    @users = User.buyer.page(params[:page])
                 .per(Settings.per_page.per_10).order_by_name
  end
end
