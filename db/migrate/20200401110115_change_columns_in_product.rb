class ChangeColumnsInProduct < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :category_id
    add_column :products, :availability, :boolean, null: false, default: false
    add_column :products, :quantity, :bigint
    add_column :products, :sku, :string
  end
end
