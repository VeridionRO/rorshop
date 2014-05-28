class CreateJoinTableProductType3 < ActiveRecord::Migration
  def change
    create_join_table :products, :type_values do |t|
      t.index [:product_id, :type_value_id], :unique => true
    end
  end
end
