# frozen_string_literal: true

# Admin::AttributesController
class Admin::AttributesController < Admin::AdminController
  before_action :set_attribute, only: %i[edit update destroy change_status]

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
    else
      flash[:alert] = 'Something went wrong.'
    end
    redirect_to admin_attributes_path
  end

  def change_status
    if @attribute.update(status: !@attribute.status)
      status = @attribute.status ? 'Activated' : 'Dectivated'
      flash[:notice] = "Attribute #{status} successfully."
    else
      flash[:alert] = @attribute.errors.full_messages.join(', ')
    end
    redirect_to admin_attributes_path
  end

  private

  def attribute_params
    params.require(:attribute).permit(:name, :code, :description, :user_id)
  end

  def set_attribute
    @attribute = Attribute.find_by(id: params[:id])
    return if @attribute.present?

    flash[:alert] = 'Product Attribute not found.'
    redirect_back(fallback_location: root_path)
  end
end
