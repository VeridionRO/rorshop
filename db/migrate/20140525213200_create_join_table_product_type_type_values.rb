class CreateJoinTableProductTypeTypeValues < ActiveRecord::Migration
  def change
    create_join_table :products_types, :type_values do |t|
      t.index [:products_type_id, :type_value_id], :name => 'products_type_id_type_value_id', :unique => true
    end
  end
end
