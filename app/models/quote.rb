class Quote < ApplicationRecord
  belongs_to :user

  has_many :items, dependent: :destroy
  
  validates_presence_of :status, :user_id
end
