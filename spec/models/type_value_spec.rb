require 'spec_helper'

describe TypeValue do

  it { should belong_to(:type) } 
  it { should have_and_belong_to_many(:products) }

  it 'is invalid without a name' do
    [:type, :value].each do |attribute|
      invalid_type_value = FactoryGirl.build(:type_value, attribute => nil)
      invalid_type_value.should_not be_valid
      invalid_type_value.errors.should have_key(attribute)
    end
  end

end
