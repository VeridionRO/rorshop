class AddPriceToProduct < ActiveRecord::Migration
  def change
    add_column :products, :price, :int, after: :description
  end
end
