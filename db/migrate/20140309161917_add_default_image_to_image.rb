class AddDefaultImageToImage < ActiveRecord::Migration
  def change
    add_column :images, :default_image, :bool, default: true, after: :product_id
  end
end
