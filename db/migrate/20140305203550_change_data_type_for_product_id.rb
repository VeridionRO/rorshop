class ChangeDataTypeForProductId < ActiveRecord::Migration
	def change
		change_column(:products, :name, :string, :null => false)
		change_column :products, :description, :string, :null => false
		change_column :images, :product_id, :int, :null => false
		change_column :images, :uri, :string, :null => false
		change_column :images, :title, :string, :null => false
  	end
end
