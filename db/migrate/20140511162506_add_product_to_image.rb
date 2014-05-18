class AddProductToImage < ActiveRecord::Migration
  def change
    add_reference :images, :product, index: true, 
      after: :id, null: false
  end
end
