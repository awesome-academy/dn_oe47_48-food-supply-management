class UsersController < ApplicationController
  before_action :logged_in_user, :is_admin?, only: :show_buyers

  def index; end

  def new; end

  def show_buyers
    return if @users = User.select_buyers.page(params[:page]).per(
      Settings.per_page.buyer
    ).order_by_name

    flash[:danger] = "Buyer does not exist!"
    redirect_to root_url
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "User does not exist!"
    redirect_to root_path
  end
end
