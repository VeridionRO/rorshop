require 'spec_helper'

describe "Products" do

  describe "/products/index" do
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
      products = Product.order('created_at DESC').limit(Product::PAG)
      filter_page_has_products products
    end
  end

  describe "displays" do

    let(:products) { FactoryGirl.build_list(:product,3) }
    let(:categories) { FactoryGirl.build_list(:category,3) }

    before(:each) do
      Product.stub(:get_page).and_return(products)
      Category.stub(:all).and_return(categories)
    end

    it "products from category" do
      visit products_index_path
      filter_page_has_products products
    end

    it "categories" do
      visit products_index_path
      has_categories categories
    end

    it "types" do
      types = FactoryGirl.create_list(:type_with_values, 3, type_values_count: 3)
      visit products_index_path
      has_types types
    end    

  end

  describe "filter" do

    it "returns filtered products" do
      type = FactoryGirl.create(:type_values_and_prods, type_values_count: 3)
      type_values = type.type_values
      products = type_values[0].products.to_a
      uri_query = type_values.to_a.to_query('where')
      visit "/products/index?#{uri_query}"
      filter_page_has_products products
      product1 = FactoryGirl.build(:product)
      product1.type_values = type_values[0..1]
      product1.save!
      products << product1
      filter_page_has_products [product1]
      page.all("//div[@id='product_list']/*").count.should equal(3)
      # filter_page_does_not_gave_product product2
    end

  end

end
