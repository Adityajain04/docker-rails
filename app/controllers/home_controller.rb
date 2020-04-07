# frozen_string_literal: true

# Root HomeController
class HomeController < ApplicationController
  
  def index
    @products = Product.available
  end
end
