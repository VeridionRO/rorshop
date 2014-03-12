Given(/^I have a valid product with a image$/) do
  @product = FactoryGirl.create(:product_with_images)
end

Given(/^I go to that product's page$/) do
  visit "/product/#{@product.id}"
end

Then(/^I should see the product's details$/) do
  page.should have_content(@product.name)
  page.should have_content(@product.description)
  page.should have_xpath("//img[@scr=\"/assets/#{@product.image.uri}\"]")
end