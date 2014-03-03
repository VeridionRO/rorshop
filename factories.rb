FactoryGirl.define do
	factory :valid_product, class: Product do
    name        Faker::Commerce.product_name
    description "Description 1"
  end
end