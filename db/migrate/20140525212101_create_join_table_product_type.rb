class CreateJoinTableProductType < ActiveRecord::Migration
  def change
    create_table :products_types do |t|
      t.integer :product_id
      t.integer :type_id
      t.index [:product_id, :type_id], :unique => true
    end
  end
end
