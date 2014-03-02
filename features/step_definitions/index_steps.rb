Given(/^I have the following products:$/) do |products|
  # table is a Cucumber::Ast::Table
  Product.create!(products)
end

Given(/^I go to the HomePage$/) do
	visit "/"
end

Then(/^I should see the favorite products$/) do
	page.should have_content("Product 1")
	page.should have_content("Product 2")
	page.should have_content("Product 3")
	page.should have_content("Product 4")
end

Then(/^I should see the Header buttons$/) do
	page.find("#topmenu").should have_content("Magazin Online")
	page.find("#topmenu").should have_content("Special")
	page.find("#topmenu").should have_content("FAQ's")
	page.find("#topmenu").should have_content("Stiri")
	page.find("#topmenu").should have_content("Contact")
end
