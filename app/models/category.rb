# frozen_string_literal: true

# Category Model
class Category < ApplicationRecord
  belongs_to :user

  has_many :categories_products
  has_many :products, through: :categories_products
end
