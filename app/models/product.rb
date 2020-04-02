# frozen_string_literal: true

# Product Model
class Product < ApplicationRecord
  belongs_to :user

  has_many :categories_products
  has_many :categories, through: :categories_products
  has_many :brands_products
  has_many :brands, through: :brands_products
  has_many :products_stores
  has_many :stores, through: :products_stores
  has_many :attribute_values_products
  has_many :attribute_values, through: :attribute_values_products
  has_many :attries, class_name: 'Attribute', through: :attribute_values

  has_many_attached :images
  attr_accessor :my_images

  validates_presence_of :name, :price, :user_id
  validates_uniqueness_of :name
end
