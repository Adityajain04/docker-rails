# frozen_string_literal: true

# Create Categories Table
class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :code
      t.text :description
      t.references :user, null: false

      t.timestamps
    end
  end
end
