require 'spec_helper'

describe "Products" do

  before(:each) do
    visit products_index_path
  end

  it "displays products page" do
    page.has_select?('Sort by', :options => ["Select","Product Name","Price","Latest Products"])
    has_header_menus
    page.should have_css(".module-categories")
    page.should have_css(".orderby_form")
  end

  it "displays products order by date" do

  end
end
