class AttributeValuesProduct < ApplicationRecord
  belongs_to :attribute_value
  belongs_to :product
end
