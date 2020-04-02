# frozen_string_literal: true

# Attribute Model
class Attribute < ApplicationRecord
  belongs_to :user

  has_many :attribute_values, dependent: :destroy
  has_many :products, through: :attribute_values

  scope :active, -> { where(status: true) }
end
