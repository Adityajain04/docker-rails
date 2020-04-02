# frozen_string_literal: true

# Admin::BrandsController
class Admin::BrandsController < Admin::AdminController
  before_action :set_brand, only: %i[edit update destroy change_status]

  def index
    @brands = Brand.all
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    @brand.user = current_user
    if @brand.save
      flash[:notice] = 'Product Brand created successfully.'
      redirect_to admin_brands_path
    else
      flash[:alert] = @brand.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit; end

  def update
    if @brand.update(brand_params)
      flash[:notice] = 'Product Brand updated successfully.'
      redirect_to admin_brands_path
    else
      flash[:alert] = @brand.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    if @brand.destroy
      flash[:notice] = 'Product Brand removed successfully.'
    else
      flash[:alert] = 'Something went wrong.'
    end
    redirect_to admin_brands_path
  end

  def change_status
    if @brand.update(status: !@brand.status)
      status = @brand.status ? 'Activated' : 'Dectivated'
      flash[:notice] = "Brand #{status} successfully."
    else
      flash[:alert] = @brand.errors.full_messages.join(', ')
    end
    redirect_to admin_brands_path
  end

  private

  def brand_params
    params.require(:brand).permit(:name, :code, :description, :user_id)
  end

  def set_brand
    @brand = Brand.find_by(id: params[:id])
    return if @brand.present?

    flash[:alert] = 'Product Brand not found.'
    redirect_back(fallback_location: root_path)
  end
end
