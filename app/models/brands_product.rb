class BrandsProduct < ApplicationRecord
  belongs_to :brand
  belongs_to :product
end
