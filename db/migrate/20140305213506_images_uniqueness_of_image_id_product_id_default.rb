class ImagesUniquenessOfImageIdProductIdDefault < ActiveRecord::Migration
	def change
		add_index :images, [:product_id, :default], :unique => true
	end
end
