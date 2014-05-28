class DropProductTypeTypeValues2 < ActiveRecord::Migration
  def change
    drop_table :products_type_values
  end
end
