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

    it 'has_many images' do
      should have_many(:images)
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
    [:name, :description, :image].each do |attribute|
      invalid_product = FactoryGirl.build(:valid_product, attribute => nil)
      invalid_product.should_not be_valid
      invalid_product.errors.should have_key(attribute)
    end
  end

  it "image should be a Hash" do
    p = Product.new
    p.image.should be_a_kind_of(Hash)
  end

  it "image is the default_image when the image_id is nil" do
    p = Product.new
    p.image.should == Product.default_img
  end

  it "image is not the default_image when the image_id is not nil" do
    p = Product.new(:images => [FactoryGirl.build(:valid_image)])
    p.image.should_not == Product.default_img
  end

  it "image is the first image from the Product images array" do
    img1 = FactoryGirl.build(:valid_image)
    img2 = FactoryGirl.build(:valid_image)
    p = Product.new(:images => [img1,img2])
    p.image.should == img1
  end

end