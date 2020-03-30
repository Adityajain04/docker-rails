class Admin::CategoriesController < Admin::AdminController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user = current_user
    if @category.save
      flash[:notice] = 'Product Category created successfully.'
      redirect_to admin_categories_path
    else
      flash[:alert] = @category.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Product Category updated successfully.'
      redirect_to admin_categories_path
    else
      flash[:alert] = @category.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = 'Product Category removed successfully.'
      redirect_to admin_categories_path
    else
      flash[:alert] = 'Something went wrong.'
      redirect_to admin_categories_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :code, :description, :user_id)
  end

  def set_category
    @category = Category.find_by(id: params[:id])
    unless @category.present?
      flash[:alert] = "Product Category not found."
      redirect_back(fallback_location: root_path)
    end
  end
end