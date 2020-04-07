class QuotesController < ApplicationController
  before_action :set_quote, only: %i[edit update destroy]

  def index
    @quotes = current_user.quotes.order('created_at')
  end

  def new
    @quote = Quote.new
    @quote.items.build
  end

  def create
    @quote = Quote.new(quote_params)
    @quote.status = 'pending'
    @quote.user_id = current_user.id
    if @quote.save
      flash[:notice] = 'Quote created successfully.'
      redirect_to quotes_path
    else
      flash[:alert] = @quote.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit; end

  def update
    if @quote.update(quote_params)
      flash[:notice] = 'Quote updated successfully.'
      redirect_to quotes_path
    else
      flash[:alert] = @quote.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    if @quote.destroy
      flash[:notice] = 'Quote removed successfully.'
    else
      flash[:alert] = @quote.errors.full_messages.join(', ')
    end
    redirect_to quotes_path
  end

  def select_price
    @product = Product.find_by(id: params[:id])
    render json: {price: @product.price}
  end

  private
  def quote_params
    params.require(:quote).permit(:user_id, :status, :comment, items_attributes: [:product_id, :quote_id, :quantity, :id])
  end

  def set_quote
    @quote = Quote.find_by(id: params[:id])
    if @quote.blank?
      flash[:alert] = 'Quote not found.'
      redirect_to quotes_path
    end
  end
end
