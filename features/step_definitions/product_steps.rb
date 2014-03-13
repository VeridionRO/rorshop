Given(/^I have a valid product with a image$/) do
  @product = FactoryGirl.create(:product_with_images)
end

Given(/^I go to that product's page$/) do
  visit "/product/#{@product.id}"
end

Then(/^I should see the product's details$/) do
  # why should I reload when I already have the product
  @p = Product.find(@product.id)
  page.should have_content(@p.name)
  page.should have_content(@p.description)
  page.should have_xpath("//img[@src='/assets/#{@p.image[:uri]}']")
end