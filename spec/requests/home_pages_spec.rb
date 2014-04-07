require 'spec_helper'

describe "HomePage" do

  it "displays the first 9 favorite products" do
    products = FactoryGirl.create_list(:valid_product, 9)
    visit "/"
    has_header_menus
    products.each do |product|
      check_product_cell_display product
    end
  end

  it "displays products with images" do
    products = [FactoryGirl.create(:valid_product, 
      :images => [FactoryGirl.create(:image)])]
    visit "/"
    products.each do |product|
      check_product_cell_display product
    end
  end

  it "has active links in the header" do
    product = FactoryGirl.create :valid_product
    visit "/product/#{product.id}"
    menus = [{:name => 'Acasa', :path => '/'}]
    menus.each do |menu|
      page.find(:xpath, 
        "//div[@id='topmenu']//a/span[text() = \"#{menu[:name]}\"]/..").click
      current_path.should == "#{menu[:path]}"
    end
  end

end