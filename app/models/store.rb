# frozen_string_literal: true

# Store Model
class Store < ApplicationRecord
  belongs_to :user

  has_many :products_stores
  has_many :products, through: :products_stores

  scope :active, -> { where(status: true) }
end
