class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.decimal :price, null: false, default: 0.0
      t.text :description, limit: 1500
      t.references :user, null: false

      t.timestamps
    end
  end
end
