# frozen_string_literal: true

# Admin::ProductsController
class Admin::ProductsController < Admin::AdminController
  before_action :set_product, only: %i[edit update destroy]

  def index
    @products = Product.all
  end

  def new
    @product = current_user.products.new
    @product.brands.build
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save
      fill_brands_product(params[:brand_id], @product.reload)
      flash[:notice] = 'Product created successfully.'
      redirect_to admin_products_path
    else
      flash[:alert] = @product.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    if @product.brands.blank?
      @product.brands.build
    end
  end

  def update
    if @product.update(product_params)
      fill_brands_product(params[:brand_id], @product)
      flash[:notice] = 'Product updated successfully.'
      redirect_to admin_products_path
    else
      flash[:alert] = @product.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:notice] = 'Product removed successfully.'
    else
      flash[:alert] = 'Something went wrong.'
    end
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(
      :name, :price, :description, :user_id, :sku, :quantity)
  end

  def set_product
    @product = Product.find_by(id: params[:id])
    return if @product.present?

    flash[:alert] = 'Product not found.'
    redirect_back(fallback_location: root_path)
  end

  def fill_brands_product(brands, product)
    brands.each do |i, brand|
      brand_product = BrandsProduct.find_or_initialize_by(
        product_id: product.id, brand_id: brand)
      brand_product.save
    end
  end
end
