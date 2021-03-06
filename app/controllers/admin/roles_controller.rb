# frozen_string_literal: true

# Admin::RolesController
class Admin::RolesController < Admin::AdminController
  before_action :set_role, only: %i[edit update destroy]

  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      flash[:notice] = 'New Role created.'
      redirect_to admin_roles_path
    else
      flash[:alert] = @role.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit; end

  def update
    if @role.update(role_params)
      flash[:notice] = 'Role updated.'
      redirect_to admin_roles_path
    else
      flash[:alert] = @role.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    if @role.destroy
      flash[:notice] = 'Role removed.'
    else
      flash[:alert] = 'Something went wrong..'
    end
    redirect_to admin_roles_path
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end

  def set_role
    @role = Role.find_by(id: params[:id])
    return if @role.present?

    flash[:alert] = 'Role not found.'
    redirect_to admin_roles_path
  end
end
