class Admin::ProductsController < Admin::AdminController
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = current_user.products.new
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save
      flash[:notice] = 'Product created successfully.'
      redirect_to admin_products_path
    else
      flash[:alert] = @product.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
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
      redirect_to admin_products_path
    else
      flash[:alert] = 'Something went wrong.'
      redirect_to admin_products_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :user_id)
  end

  def set_product
    @product = Product.find_by(id: params[:id])
    unless @product.present?
      flash[:alert] = "Product not found."
      redirect_back(fallback_location: root_path)
    end
  end
end