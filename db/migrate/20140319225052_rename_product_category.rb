class RenameProductCategory < ActiveRecord::Migration
  def change
    rename_table :categories_products, :product_categories
  end
end
