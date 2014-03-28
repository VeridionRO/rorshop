require 'spec_helper'

describe Type do

  it 'is invalid without a name' do
    [:name].each do |attribute|
      invalid_type = FactoryGirl.build(:type, attribute => nil)
      invalid_type.should_not be_valid
      invalid_type.errors.should have_key(attribute)
    end
  end

  it { should have_many(:type_values) } 

end
