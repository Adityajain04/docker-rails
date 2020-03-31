class AttributeValue < ApplicationRecord
  belongs_to :user
  belongs_to :attri, class_name: 'Attribute', :foreign_key => "attribute_id"
end
