require 'spec_helper'

describe "Admin::DeleteProducts" do
  describe "GET /admin_delete_products" do
    it "works! (now write some real specs)" do
      product = FactoryGirl.create :product
      visit admin_products_path
      page.find(:xpath, "//tbody/tr[1]//a[2]").click

      page.should_not have_content(product.name)
      page.should_not have_content(product.description)
      page.should_not have_content(product.price)
    end
  end
end
