class AttributeValue < ApplicationRecord
  belongs_to :user
  belongs_to :attribute
end
