# frozen_string_literal: true

# Create Attributes Table
class CreateAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :attributes do |t|
      t.string :name, null: false
      t.string :code
      t.boolean :status, null: false, default: false
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
