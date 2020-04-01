# frozen_string_literal: true

# ProductsStore Join Model
class ProductsStore < ApplicationRecord
  belongs_to :store
  belongs_to :product
end
