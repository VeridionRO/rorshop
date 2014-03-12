require 'spec_helper'

describe Image do
  it "has uniqueness for product_id, default" do
    #shoulda (gem) method validate_uniqueness_of needs to have one object 
    #in the database or it will give a sql error for NOT NULL columns
    valid_image = FactoryGirl.create(:valid_image)
    should validate_uniqueness_of(:product)
      .scoped_to(:default_image)
      .with_message(/product_id and default_image must be unique/)
  end

  [:title, :uri].each do |attribute|
    it "is invalid without an/a #{attribute}" do
      invalid_image = FactoryGirl.build(:valid_image, attribute => nil)
      invalid_image.should_not be_valid
      invalid_image.errors.should have_key(attribute)
    end
  end

  it "has a default true value on default_image" do
    valid_image = FactoryGirl.build(:valid_image)
    valid_image.default_image.should == true
  end

  it "belongs_to" do
    should belong_to(:product)
  end

end
