class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name, null: false
      t.string :code
      t.text :descriptoiin
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
