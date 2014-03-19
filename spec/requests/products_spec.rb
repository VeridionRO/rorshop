require 'spec_helper'

describe "Products" do

  before(:each) do
    visit products_index_path
  end

  it "displays products page"do
    page.should have_select("Sorteaza dupa", 
      :with_options => ["Cele mai noi", "Pret", "Nume"])
    has_header_menus
    page.should have_css(".module-categories")
    page.should have_css(".orderby_form")
  end

  it "displays products order by date on product page" do
    products = Product.order('created_at DESC').limit(10)
    counter = 1
    products.each do |product|
      page.find("//div[@id='product_list']/*[#{counter}]").should have_content(
        product.name)
      counter += 1
    end
  end
end
