# frozen_string_literal: true

# Admin::StoresController
class Admin::StoresController < Admin::AdminController
  before_action :set_store, only: %i[edit update destroy]

  def index
    @stores = Store.all
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    @store.user = current_user
    if @store.save
      flash[:notice] = 'Product Store created successfully.'
      redirect_to admin_stores_path
    else
      flash[:alert] = @store.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit; end

  def update
    if @store.update(store_params)
      flash[:notice] = 'Product Store updated successfully.'
      redirect_to admin_stores_path
    else
      flash[:alert] = @store.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    if @store.destroy
      flash[:notice] = 'Product Store removed successfully.'
    else
      flash[:alert] = 'Something went wrong.'
    end
    redirect_to admin_stores_path
  end

  private

  def store_params
    params.require(:store).permit(:name, :code, :description, :user_id)
  end

  def set_store
    @store = Store.find_by(id: params[:id])
    return if @store.present?

    flash[:alert] = 'Product Store not found.'
    redirect_back(fallback_location: root_path)
  end
end
