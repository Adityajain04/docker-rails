# frozen_string_literal: true

# CategoriesProduct Join Model
class CategoriesProduct < ApplicationRecord
  belongs_to :category
  belongs_to :product
end
