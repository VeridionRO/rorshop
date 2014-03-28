require 'spec_helper'

describe Category do

  it { should have_and_belong_to_many(:products) }
  it 'is invalid without a name' do
    [:name].each do |attribute|
      invalid_category = FactoryGirl.build(:category, attribute => nil)
      invalid_category.should_not be_valid
      invalid_category.errors.should have_key(attribute)
    end
  end

end