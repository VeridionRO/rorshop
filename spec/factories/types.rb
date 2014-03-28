# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :type do
    name Faker::Lorem.word
  end

  # p = FactoryGirl.create(:type_with_values, type_values_count: 3)
  factory :type_with_values, parent: :type do
    ignore do
      type_values_count 1
    end
    after(:create) do |type, evaluator|
      FactoryGirl.create_list(:type_value, evaluator.type_values_count,
        type: type)
    end
  end
  
end
