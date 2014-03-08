require 'spec_helper'

describe Product do

  describe 'attribute' do
    let(:product) { FactoryGirl.build(:valid_product) }

    it 'responds to name' do
      product.name = 'name 1'
      product.name.should eq('name 1')
    end

    it 'responds to description' do
      product.description = 'description 1'
      product.description.should eq('description 1')
    end

    it 'responds to image' do
      image = FactoryGirl.build(:valid_image)
      product.image = image
      product.image.should eq(image)
    end

    it 'has_many images' do
      should have_many(:images)
    end

    it 'has_one image' do
       should have_one(:image)
    end

  end

  describe 'methods' do
    it 'favorite_products' do
      products = FactoryGirl.create_list(:valid_product, 18)
      products.sort! { |a, b| b.id <=> a.id }
      Product.favorite_products.should eq(products[0..8])
    end
  end


  it 'is invalid without a name or description' do
    [:name, :description].each do |attribute|
      invalid_product = FactoryGirl.build(:valid_product, attribute => nil)
      invalid_product.should_not be_valid
      invalid_product.errors.should have_key(attribute)
    end
  end

  it 'is valid without a image' do
    [:image].each do |attribute|
      valid_product = FactoryGirl.build(:valid_product, attribute => nil)
      valid_product.should be_valid
    end
  end

  it 'has a default_img class object' do
    image = FactoryGirl.build(:valid_image)
    Product.stub(:default_img).and_return(image)
    Product.default_img.should == image
  end

  it 'default_img method returns a Image object' do
    Product.default_img.should be_a_kind_of(Image)
  end

  it 'default_img method returns a valid Image object' do
    Product.default_img.should be_valid
  end

  context 'when image_id' do
    context 'is nil' do
      it 'default_image shoud not be nil' do
        product = Product.new
        product.default_image.should == Product.default_img
      end
    end

    context 'is not nil' do
      it 'default_image shoud be nil' do
        product = Product.new(:image_id => 1)
        product.default_image.should == nil
      end
    end
  end

end