require 'spec_helper'

describe Product do

	describe "attributes" do
		let(:product) { FactoryGirl.build(:valid_product) }
		it "responds to name" do
			product.name = "name 1"
			product.name.should eq("name 1")
		end

		it "responds to description" do
			product.description = "description 1"
			product.description.should eq("description 1")
		end

		it "is invalid without a name" do
			[:name, :description].each do |attribute|
				invalid_product = FactoryGirl.build(:valid_product, attribute => '')
				invalid_product.should_not be_valid
				invalid_product.errors.should have_key(attribute)
			end
		end
	end

	describe "methods" do
		it "favorite_products" do
			products = FactoryGirl.create_list(:valid_product, 18)
			products.sort! { |a, b| b.id <=> a.id }
			Product.favorite_products.should eq(products[0..8])
		end

	end

end
