require 'spec_helper'

describe "Admin::Products" do
  describe "GET /admin/products" do
    it "works! (now write some real specs)" do
      products = FactoryGirl.create_list(:product, 9)
      visit admin_products_path
      table = page.find(".table")
      products.each do |product|
        table.should have_content(product.name)
        table.should have_content(product.description)
        table.should have_content(product.price)
      end
    end
  end
end
