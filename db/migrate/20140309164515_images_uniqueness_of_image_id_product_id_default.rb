class ImagesUniquenessOfImageIdProductIdDefault < ActiveRecord::Migration
	def change
		add_index :images, [:product_id, :default_image], :unique => true
	end
end