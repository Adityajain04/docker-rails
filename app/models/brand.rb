class Brand < ApplicationRecord
  belongs_to :user

  has_many :brands_products
  has_many :products, through: :brands_products
end
