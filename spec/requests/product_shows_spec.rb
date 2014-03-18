require 'spec_helper'

describe "Product Show" do

  it "displays details of the product with both neighbours" do
    products = FactoryGirl.create_list(:product_with_images, 3)
    product = Product.find(products[1].id)
    product.get_neighbours
    visit "/product/#{product.id}"
    check_product_display product
  end

  it "displays details of the product with only previous neighbour" do
    product = Product.last
    product.get_neighbours
    visit "/product/#{product.id}"
    check_product_display product
  end

  it "displays details of the product with only next neighbour" do
    product = Product.first
    product.get_neighbours
    visit "/product/#{product.id}"
    check_product_display product
  end

end
