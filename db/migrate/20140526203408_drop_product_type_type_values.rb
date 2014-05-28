class DropProductTypeTypeValues < ActiveRecord::Migration
  def change
    drop_table :products_types_type_values
  end
end