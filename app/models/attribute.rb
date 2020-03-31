class Attribute < ApplicationRecord
  belongs_to :user

  has_many :attribute_values, dependent: :destroy
  has_many :products, through: :attribute_values
end
