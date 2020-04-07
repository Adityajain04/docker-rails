class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :quote, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :quantity

      t.timestamps
    end
  end
end
