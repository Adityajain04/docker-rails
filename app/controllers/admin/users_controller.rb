class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:edit, :update]

  def normal_users
    @users = User.normal
  end

  def admin_users
    @users = User.admin
  end

  def edit
    @roles = Role.where('name not in (?)', @user.roles.map(&:name))
  end

  def update
    @user.add_role(role) unless @user.has_role?(role)
    # params[:roles][:name].each do |i, role|
    #   @user.add_role(role) unless @user.has_role?(role)
    # end
    flash[:notice] = 'Roles added to user.'
    redirect_to root_path
  end

  private
  def set_user
    @user = User.find_by(id: params[:id])
    unless @user.present?
      flash[:alert] = "User not found."
      redirect_back(fallback_location: root_path)
    end
  end
end