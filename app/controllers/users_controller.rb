class UsersController < ApplicationController
  before_action :load_user, only: :show

  def new; end

  def show; end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "user.nil"
    redirect_to root_path
  end
end
