class CreateAttributeValuesProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :attribute_values_products do |t|
      t.references :attribute_value, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
