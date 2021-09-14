class Admin::AdminsController < ApplicationController
  before_action :logged_in_user, :is_admin?

  def index; end
end
