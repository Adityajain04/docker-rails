class AddStatusToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :status, :boolean, null: false, default: false
  end
end
