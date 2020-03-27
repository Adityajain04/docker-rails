class Product < ApplicationRecord
  belongs_to :user

  validates_presence_of :name, :price, :user_id
  validates_uniqueness_of :name
end
