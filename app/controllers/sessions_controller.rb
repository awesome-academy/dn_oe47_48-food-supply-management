class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:sessions][:email].downcase
    if user&.authenticate(params[:sessions][:password])
      log_in user
      is_remember? user
      flash[:success] = t "user.login.success"
      redirect_back_or user
    else
      flash.now[:danger] = t "user.login.failed"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = t "user.logout.success"
    redirect_to root_url
  end

  private

  def is_remember? user
    params[:sessions][:remember_me] == "1" ? remember(user) : forget(user)
  end
end
