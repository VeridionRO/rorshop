# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shopping_cart do
    user nil
    delivered_on "2014-08-10"
    comments "MyText"
  end
end
