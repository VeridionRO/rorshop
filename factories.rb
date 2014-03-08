FactoryGirl.define do
  factory :valid_image, class: Image do
    product_id 1
    title      "test"
    uri        "Product01_resized.png"
  end
  
  factory :valid_product, class: Product do
    name        "test"
    description "Description 1"
  end

  factory :valid_product_with_image, class: Product do
    name        "test"
    description "Description 1"
    image_id    1
    image       FactoryGirl.build(:valid_image)
  end
end