class CheckoutService
  def initialize(quote_id)
    if quote_id
      @quote = Quote.find_by(id: quote_id)
      if @quote.blank?
        raise 'Quote is not found.'
      end
    end
  end

  def checkout
    debugger
    ActiveRecord::Base.transaction do
      update_quote_status
      add_order
    end
  end

  private
  def update_quote_status
    @quote.update(status: 'checkout')
  end

  def add_order

  end
end