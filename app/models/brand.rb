# frozen_string_literal: true

# Brand Model
class Brand < ApplicationRecord
  belongs_to :user

  has_many :brands_products
  has_many :products, through: :brands_products

  scope :active, -> { where(status: true) }
end
