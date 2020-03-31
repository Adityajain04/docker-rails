class Store < ApplicationRecord
  belongs_to :user

  has_many :products_stores
  has_many :products, through: :products_stores
end
