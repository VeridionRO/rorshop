class DropProductTypeValues < ActiveRecord::Migration
  def change
    drop_table :products_types
  end
end
