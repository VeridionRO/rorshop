FactoryGirl.define do

  factory :valid_product, class: Product do
    name        Faker::Commerce.product_name
    description Faker::Lorem.paragraph
  end

  factory :valid_image, class: Image do
    title   Faker::Commerce.department
    uri     "Product01_resized.png"
    product FactoryGirl.create(:valid_product)
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
  end

  factory :product_with_images, parent: :product do
    ignore do
      image { FactoryGirl.create(:image) }
    end

    after(:create) do |product, evaluator|
      product.images << evaluator.image
    end
  end

  factory :product_category do
    association :product
    association :category
  end

  # c = FactoryGirl.create(:category_with_product, products_count: 10)
  factory :category_with_product, parent: :category do
    ignore do
      products_count 1
    end
    after(:create) do |category, evaluator|
      FactoryGirl.create_list(:product, evaluator.products_count,
        categories: [category])
    end
  end

  # p = FactoryGirl.create(:product_with_categories, categories_count: 10)
  factory :product_with_categories, parent: :product do
    ignore do
      categories_count 1
    end
    after(:create) do |product, evaluator|
      FactoryGirl.create_list(:category, evaluator.categories_count,
        products: [product])
    end
  end

end