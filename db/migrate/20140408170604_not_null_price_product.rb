class NotNullPriceProduct < ActiveRecord::Migration
  def change
    change_column :products, :price, :int, :null => false
  end
end
