FactoryGirl.define do

  factory :valid_product, class: Product do
    name        Faker::Commerce.product_name
    description Faker::Lorem.paragraph
  end


  factory :valid_image, class: Image do
    title      Faker::Commerce.department
    uri        "Product01_resized.png"
    product    FactoryGirl.create(:valid_product)
  end

  factory :image, class: Image do
    title   Faker::Commerce.department
    uri     "Product01_resized.png"
    product 
  end

  factory :valid_image_hash do
    title Faker::Commerce.department
    uri   Faker::Lorem.paragraph
  end

  factory :product, class: Product do
    name        Faker::Commerce.product_name
    description Faker::Lorem.paragraph

    factory :product_with_images do
      ignore do
        posts_count 1
      end

      after(:create) do |product, evaluator|
        FactoryGirl.create_list(:image, evaluator.posts_count, product: product)
      end
    end
  end

end