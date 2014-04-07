require 'spec_helper'

describe "Product Show" do

  before do
    @products = FactoryGirl.create_list(:product_with_images, 3)
  end

  it "displays details of the product with both neighbours" do
    product = Product.find(@products[1].id)
    product.get_neighbours
    visit "/product/#{product.id}"
    check_product_display product
  end

  it "displays details of the product with only previous neighbour" do
    product = Product.find(@products[0].id)
    product.get_neighbours
    visit "/product/#{product.id}"
    check_product_display product
  end

  it "displays details of the product with only next neighbour" do
    product = Product.find(@products[2].id)
    product.get_neighbours
    visit "/product/#{product.id}"
    check_product_display product
  end

end
