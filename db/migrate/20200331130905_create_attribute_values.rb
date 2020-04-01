# frozen_string_literal: true

# Create AttributeValues Table
class CreateAttributeValues < ActiveRecord::Migration[6.0]
  def change
    create_table :attribute_values do |t|
      t.string :name, null: false
      t.string :code
      t.boolean :status, null: false, default: false
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :attribute, null: false, foreign_key: true

      t.timestamps
    end
  end
end
