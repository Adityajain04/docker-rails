# frozen_string_literal: true

# Migration ProductsStores Join Table
class CreateProductsStores < ActiveRecord::Migration[6.0]
  def change
    create_table :products_stores do |t|
      t.references :store, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
