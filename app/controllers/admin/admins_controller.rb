class Admin::AdminsController < ApplicationController
  before_action :logged_in_user, :is_admin?

  def index
    @users = User.admin.order_by_name.page(params[:page])
                 .per(Settings.per_page.per_10)
  end
end
