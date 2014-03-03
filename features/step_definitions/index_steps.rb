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
