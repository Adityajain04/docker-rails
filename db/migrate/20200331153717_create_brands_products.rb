# frozen_string_literal: true

# Migration BrandsProducts join Table
class CreateBrandsProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :brands_products do |t|
      t.references :brand, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
