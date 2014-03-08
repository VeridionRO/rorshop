Given(/^I have the following products:$/) do |products|
  # table is a Cucumber::Ast::Table
  Product.create!(products.hashes)
end

Given(/^I go to the HomePage$/) do
  visit "/"
end

Then(/^I should see the last 9 products$/) do
  page.should have_content("Product 1")
  page.should have_content("Product 2")
  page.should have_content("Product 3")
  page.should have_content("Product 4")
  page.should have_content("Product 9")
  page.should have_content("Product 9")
  page.should have_selector(".default-image")
  page.should_not have_content("Product 10")
end

Then(/^I should see the Header buttons$/) do
  page.find("#topmenu").should have_content("Acasa")
  page.find("#topmenu").should have_content("Magazin Online")
  page.find("#topmenu").should have_content("Special")
  page.find("#topmenu").should have_content("FAQ's")
  page.find("#topmenu").should have_content("Stiri")
  page.find("#topmenu").should have_content("Contact")
end

Given(/^I have products with images$/) do
  @products = [FactoryGirl.create(:valid_product_with_image)]
end

Then(/^I should see the products$/) do
  @products.each do |product|
    page.find("#product-cell-#{product.id}").should have_content(product.name)
  end
  page.should_not have_selector(".default-image")
end