class CreateJoinTableProductTypeValues < ActiveRecord::Migration
  def change
    create_join_table :products, :type_values do |t|
      t.index [:product_id, :type_value_id], :unique => true
      # t.index [:type_value_id, :product_id]
    end
  end
end
