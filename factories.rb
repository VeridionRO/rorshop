FactoryGirl.define do

  factory :valid_product, class: Product do
    name        "test"
    description "Description 1"
  end


  factory :valid_image, class: Image do
    title      "test"
    uri        "Product01_resized.png"
    product    FactoryGirl.create(:valid_product)
  end

  factory :image, class: Image do
    title   "test"
    uri     "Product01_resized.png"
    product 
  end

  factory :valid_image_hash do
    title "test"
    uri   "Description 1"
  end

  factory :product, class: Product do
    name        "test"
    description "Description 1"

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