# frozen_string_literal: true

# Admin::AttributeValuesController
class Admin::AttributeValuesController < Admin::AdminController
  before_action :set_attribute
  before_action :set_attribute_value, only: %i[edit update destroy]

  def index
    @attribute_values = @attribute.attribute_values
  end

  def new
    @attribute_value = @attribute.attribute_values.new
  end

  def create
    @attribute_value = @attribute.attribute_values.new(attribute_value_params)
    @attribute_value.user = current_user
    if @attribute_value.save
      flash[:notice] = 'Attribute Value created successfully.'
      redirect_to admin_attribute_attribute_values_path(@attribute)
    else
      flash[:alert] = @attribute_value.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit; end

  def update
    if @attribute_value.update(attribute_value_params)
      flash[:notice] = 'Attribute Value updated successfully.'
      redirect_to admin_attribute_attribute_values_path(@attribute)
    else
      flash[:alert] = @attribute_value.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    if @attribute_value.destroy
      flash[:notice] = 'Attribute Value removed successfully.'
    else
      flash[:alert] = 'Something went wrong.'
    end
    redirect_to admin_attribute_attribute_values_path(@attribute)
  end

  private

  def attribute_value_params
    params.require(:attribute_value).permit(
      :name, :code, :description, :user_id, :attribute_id
    )
  end

  def set_attribute
    @attribute = Attribute.find_by(id: params[:attribute_id])
    return if @attribute.present?

    flash[:alert] = 'Product Attribute not found.'
    redirect_back(fallback_location: root_path)
  end

  def set_attribute_value
    @attribute_value = AttributeValue.find_by(id: params[:id])
    return if @attribute_value.present?

    flash[:alert] = 'AttributeValue not found.'
    redirect_back(fallback_location: root_path)
  end
end
