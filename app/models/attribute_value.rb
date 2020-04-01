# frozen_string_literal: true

# AttributeValue Model
class AttributeValue < ApplicationRecord
  belongs_to :user
  belongs_to :attry, class_name: 'Attribute', foreign_key: 'attribute_id'

  has_many :attribute_values_products
  has_many :products, through: :attribute_values_products
end
