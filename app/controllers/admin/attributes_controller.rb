class Admin::AttributesController < Admin::AdminController
  before_action :set_attribute, only: [:edit, :update, :destroy]

  def index
    @attributes = Attribute.all
  end

  def new
    @attribute = Attribute.new
  end

  def create
    @attribute = Attribute.new(attribute_params)
    @attribute.user = current_user
    if @attribute.save
      flash[:notice] = 'Product Attribute created successfully.'
      redirect_to admin_attributes_path
    else
      flash[:alert] = @attribute.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit; end

  def update
    if @attribute.update(attribute_params)
      flash[:notice] = 'Product Attribute updated successfully.'
      redirect_to admin_attributes_path
    else
      flash[:alert] = @attribute.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    if @attribute.destroy
      flash[:notice] = 'Product Attribute removed successfully.'
      redirect_to admin_attributes_path
    else
      flash[:alert] = 'Something went wrong.'
      redirect_to admin_attributes_path
    end
  end

  private

  def attribute_params
    params.require(:attribute).permit(:name, :code, :description, :user_id)
  end

  def set_attribute
    @attribute = Attribute.find_by(id: params[:id])
    unless @attribute.present?
      flash[:alert] = "Product Attribute not found."
      redirect_back(fallback_location: root_path)
    end
  end
end