class Admin::UsersController < Admin::AdminController
  def normal_users
    @users = User.normal
  end

  def admin_users
    @users = User.admin
  end
end