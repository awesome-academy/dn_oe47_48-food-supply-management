class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :set_locale, :create_cart, :load_products
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if user_signed_in?

    store_location
    flash[:warning] = t "user.login.require"
    redirect_to login_path
  end

  def is_admin?
    return if current_user.admin?

    flash[:warning] = t "user.login.isnt_admin"
    redirect_to root_url
  end

  def create_cart
    session[:cart] ||= {}
  end
end
