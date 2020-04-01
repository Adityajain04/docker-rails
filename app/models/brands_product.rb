# frozen_string_literal: true

# BrandsProduct Join Model
class BrandsProduct < ApplicationRecord
  belongs_to :brand
  belongs_to :product
end
