class ChangePriceFromIntToFloat < ActiveRecord::Migration
  def change
    change_column :products, :price, :float, :null => false
  end
end
