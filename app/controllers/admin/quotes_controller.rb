# frozen_string_literal: true

# Admin::QuotesController
class Admin::QuotesController < Admin::AdminController
  before_action :set_quote, only: %i[show reject accept]
  
  def index
    @quotes = Quote.all.order('created_at desc')
  end

  def show

  end

  def reject
    if @quote.update(status: 'rejected')
      flash[:notice] = 'Requested Quote rejected.'
    else
      flash[:notice] = 'Something went wrong.'
    end
    redirect_to admin_quotes_url
  end

  def accept
    if @quote.update(status: 'accepted')
      flash[:notice] = 'Requested Quote accepted.'
    else
      flash[:notice] = 'Something went wrong.'
    end
    redirect_to admin_quotes_url
  end

  private
  def set_quote
    @quote = Quote.find_by(id: params[:id])
    if @quote.blank?
      flash[:alert] = 'Quote not found.'
      redirect_to admin_quotes_url and return
    end
  end
end
