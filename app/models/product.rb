class Product < ActiveRecord::Base
	validates :name, :description, presence: true

	def self.favorite_products
		Product.order('id DESC').limit(9)
	end
end
