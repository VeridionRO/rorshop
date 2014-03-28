class RenameProductCategory2 < ActiveRecord::Migration
  def change
    rename_table :product_categories, :categories_products
  end
end
