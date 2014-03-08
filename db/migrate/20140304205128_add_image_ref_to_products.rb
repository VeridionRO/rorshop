class AddImageRefToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :image, index: true, after: :id
  end
end
