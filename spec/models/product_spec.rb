require 'spec_helper'

describe Product do

	describe "attributes" do
		let(:product) { Product.new }
		it "responds to name" do
			product.name = "name 1"
			product.name.should eq("name 1")
		end

		it "responds to description" do
			product.description = "description 1"
			product.description.should eq("description 1")
		end
	end

end
