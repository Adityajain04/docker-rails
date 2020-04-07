class Quote < ApplicationRecord
  belongs_to :user

  has_many :items, dependent: :destroy
  
  accepts_nested_attributes_for :items  
  
  validates_presence_of :status, :user_id
end
