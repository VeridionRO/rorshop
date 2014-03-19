require 'spec_helper'

describe Product do

  describe 'attribute' do
    let(:product) { Product.new }

    it 'responds to name' do
      product.name = 'name 1'
      product.name.should eq('name 1')
    end

    it 'responds to description' do
      product.description = 'description 1'
      product.description.should eq('description 1')
    end

    it 'responds to neighbours' do
      product.neighbours = {}
      product.neighbours.should eq({})
    end

    it "neighbours is a Hash" do
      product.stub(:get_neighbours).and_return({})
      product.get_neighbours.should be_a_kind_of(Hash)
    end

    it 'has_many images' do
      should have_many(:images)
    end

  end

  describe "class method" do
    it { Product.should respond_to(:favorite_products) }
    it { Product.should respond_to(:default_img) }
    it { Product.should respond_to(:get_page) }
  end

  describe 'method' do

    it { should respond_to(:neighbour) }
    it { should respond_to(:get_neighbours) }
    it { should respond_to(:add_image) }

    it 'favorite_products' do
      products = FactoryGirl.create_list(:valid_product, 18)
      products.sort! { |a, b| b.id <=> a.id }
      Product.favorite_products.should eq(products[0..8])
    end

    describe "get_neighbours" do

      it "with both neighbours" do
        products = FactoryGirl.create_list(:valid_product, 3)
        neighbours = {
          :previous => products[0],
          :next => products[2]
        }
        products[1].get_neighbours
                   .should eq(neighbours)
      end

      it "with only previous neighbour" do
        products = FactoryGirl.create_list(:valid_product, 2)
        neighbours = {
          :previous => products[0],
          :next => nil
        }
        products[1].get_neighbours
                   .should eq(neighbours)
      end

      it "with only next neighbour" do
        current_product = Product.first
        next_product = Product.where("id > #{current_product.id}").first
        neighbours = {:previous => nil, :next => next_product}
        current_product.get_neighbours.should eq(neighbours)
      end
   
      it "raises an exception when called with an unsaved product" do
        product = Product.new
        lambda { product.get_neighbours }.should raise_exception(
          ProductException::CannotHaveNeighbours,
          "Unsaved product cannot have neighbours")
      end

    end

    describe "neighbour" do

      it "raises an exception when called with a unsaved product" do
        product = Product.new
        lambda { product.neighbour :previous }.should raise_exception(
          ProductException::CannotHaveNeighbours,
          "Unsaved product cannot have neighbours")
      end

      it "calls get_neighbours when neighbours is null" do
        product = Product.new(:id => 1)
        product.stub(:get_neighbours)
        product.should_receive(:get_neighbours)
        product.neighbour :previous
      end

      describe "return the" do

        before(:each) do
          @product = Product.new(:id => 1)
          @next_neighbour = Product.new
          @previous_neighbour = Product.new
          @product.neighbours = {:previous => @previous_neighbour, 
            :next => @next_neighbour}
        end

        it "next neighbour" do
          @product.neighbour(:next).should equal(@next_neighbour)
        end

        it "previous neighbour" do
          @product.neighbour(:previous).should equal(@previous_neighbour)
        end
        
      end

      it "returns nil when a invalid neighbour is passed" do
        product = Product.new(:id => 1)
        product.stub(:get_neighbours)
        expect(product.neighbour(:invalid_neighbour)).to be_nil
      end

    end

    describe "get_page" do

      it "returns the last 10/20/30... elements" do
        products = Product.order('created_at DESC').limit(10).offset(0)
        expect(Product.get_page(0)).to eq(products)
        products = Product.order('created_at DESC').limit(10).offset(10)
        expect(Product.get_page(1)).to eq(products)
      end

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