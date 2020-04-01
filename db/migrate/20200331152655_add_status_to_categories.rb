# frozen_string_literal: true

# Add Status To Category Table
class AddStatusToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :status, :boolean, null: false, default: false
  end
end
