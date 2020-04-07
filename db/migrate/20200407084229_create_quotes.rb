class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.text :comment

      t.timestamps
    end
  end
end
