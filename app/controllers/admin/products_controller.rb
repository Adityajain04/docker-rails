# frozen_string_literal: true

# Admin::ProductsController
class Admin::ProductsController < Admin::AdminController
  before_action :set_product, only: %i[edit update destroy remove_attachment change_availability]

  def index
    @products = Product.all
  end

  def new
    @product = current_user.products.new
  end

  def create
    @product = current_user.products.new(product_params)
    @product.images.attach(params[:product][:my_images]) if params[:product][:my_images].present?
    if @product.save
      join_ids = {
        'BrandsProduct': params[:brand_id].blank? ? [] : params[:brand_id],
        'CategoriesProduct': params[:category_id].blank? ? [] : params[:category_id],
        'ProductsStore': params[:store_id].blank? ? [] : params[:store_id],
        'AttributeValuesProduct': params[:attribute_value_id].blank? ? [] : params[:attribute_value_id]
      }
      fill_join_association(join_ids, @product.reload)
      flash[:notice] = 'Product created successfully.'
      redirect_to admin_products_path
    else
      flash[:alert] = @product.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      @product.images.attach(params[:product][:my_images]) if params[:product][:my_images].present?
      join_ids = {
        'BrandsProduct': params[:brand_id].blank? ? [] : params[:brand_id],
        'CategoriesProduct': params[:category_id].blank? ? [] : params[:category_id],
        'ProductsStore': params[:store_id].blank? ? [] : params[:store_id],
        'AttributeValuesProduct': params[:attribute_value_id].blank? ? [] : params[:attribute_value_id]
      }
      fill_join_association(join_ids, @product.reload)
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

  def remove_attachment
    @image = ActiveStorage::Attachment.find(params[:attachment_id])
    @image.purge
    redirect_to edit_admin_product_url(@product.id)
  end

  def change_availability
    if @product.update(availability: !@product.availability)
      availability = @product.reload.availability ? 'available' : 'not available'
      flash[:notice] = "Product is #{availability} now."
      redirect_to admin_products_path
    else
      flash[:alert] = @product.errors.full_messages.join(', ')
      redirect_to admin_products_path
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :name, :price, :description, :user_id, :sku, :quantity, my_images: [])
  end

  def set_product
    @product = Product.find_by(id: params[:id])
    return if @product.present?

    flash[:alert] = 'Product not found.'
    redirect_back(fallback_location: root_path)
  end

  def fill_join_association(join_ids, product)
    join_ids.each do |model, ids|
      ids.each do |i, id|
        if model.to_s.underscore.split('_product')[0].include?('product')
          name = model.to_s.underscore.split('_')[1].singularize
        else
          name = model.to_s.underscore.split('_product')[0].singularize
        end
        model.to_s.constantize.find_or_initialize_by(
          product_id: product.id, "#{name}_id": id).save
      end
    end
  end
end
