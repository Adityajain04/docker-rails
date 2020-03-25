class Admin::AdminController < ApplicationController
  before_action :check_admin?
  
  def check_admin?
    return if current_user.has_role?(:admin)
    flash[:alert] = 'You are not authorized to access.'
    redirect_to root_path and return
  end
end