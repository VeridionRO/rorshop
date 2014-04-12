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

    it 'responds to price' do
      product.price = 10
      product.price.should eq(10)
    end

    it 'responds to neighbours' do
      product.neighbours = {}
      product.neighbours.should eq({})
    end

    it "neighbours is a Hash" do
      product.stub(:get_neighbours).and_return({})
      product.get_neighbours.should be_a_kind_of(Hash)
    end

    it "PAG" do
      stub_const("Product::PAG", 2)
      Product::PAG.should equal(2)
    end

    it { should have_many(:images) }
    it { should have_and_belong_to_many(:categories) }
    it { should have_and_belong_to_many(:type_values) }

  end

  describe "scopes" do
    it { Product.should respond_to(:filter_type_values) }
  end

  describe "class method" do
    it { Product.should respond_to(:favorite_products) }
    it { Product.should respond_to(:default_img) }
    it { Product.should respond_to(:get_page) }
    it { Product.should respond_to(:filter_params) }
    it { Product.should respond_to(:get_results) }
  end

  describe 'method' do

    it { should respond_to(:neighbour) }
    it { should respond_to(:get_neighbours) }
    it { should respond_to(:add_image) }

    it 'favorite_products' do
      products = FactoryGirl.create_list(:product, 18)
      products.sort! { |a, b| b.id <=> a.id }
      Product.favorite_products.should eq(products[0..8])
    end

    describe "get_neighbours" do

      let(:products) { FactoryGirl.create_list(:product, 3) }

      it "with both neighbours" do
        neighbours = {
          :previous => products[0],
          :next => products[2]
        }
        products[1].get_neighbours
                   .should eq(neighbours)
      end

      it "with only previous neighbour" do
        neighbours = {
          :previous => products[1],
          :next => nil
        }
        products[2].get_neighbours
                   .should eq(neighbours)
      end

      it "with only next neighbour" do
        neighbours = {
          :previous => nil,
          :next => products[1]
        }
        products[0].get_neighbours
                   .should eq(neighbours)
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
          @product.neighbours = {
            :previous => @previous_neighbour, 
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

      it "returns the last 10 elements" do
        # @todo these tests don't do shit!!! the database is empty
        products = Product.order('created_at DESC')
                          .limit(Product::PAG).offset(0)
        expect(Product.get_page({
          :page => 1
        })).to eq(products)
      end

      it "returns the last 20 elements" do
        # @todo these tests don't do shit!!! the database is empty
        products = Product.order('created_at DESC')
                          .limit(Product::PAG)
                          .offset(Product::PAG)
        expect(Product.get_page({
          :page => 2
        })).to eq(products)
      end

      it "with type_values" do
        type = FactoryGirl.create(:type_values_and_prods, type_values_count: 3)
        type_values = type.type_values
        products = type_values[0].products
        expect(Product.get_page({:where => type_values.ids}).to_a).to eq(products.to_a)
      end

      it "calls filter_params" do
        Product.should_receive(:filter_params)
        Product.stub(:get_results)
        Product.get_page
      end

      it "calls get_results" do
        Product.should_receive(:get_results)
        Product.get_page
      end

      it "sorts results by price" do
        products = FactoryGirl.build_list(:product, 4)
        price = 20
        products.each do |product|
          product.price = price
          price += 1
          product.save!
        end
        page_products = Product.get_page({:order => '2'})
        expect(page_products[0]).to eq(products[3])
        expect(page_products[3]).to eq(products[0])
      end

    end

    describe "filter_params" do

      it "with empty hash {}" do
        Product.filter_params({}).should eql({:page => 1, :where => [], 
          :category_id => nil, :order => 'created_at'})
      end

      it "with hash {:category_id => 1}" do
        Product.filter_params({:category_id => 1}).should eql({
          :page => 1, :where => [], 
          :category_id => 1, :order => 'created_at'})
      end

      it "with hash {:order => 1}" do
        Product.filter_params({:order => '1'}).should eql({
          :page => 1, :where => [], 
          :category_id => nil, :order => 'created_at'})
      end

      it "with hash {:order => 2}" do
        Product.filter_params({:order => '2'}).should eql({
          :page => 1, :where => [], 
          :category_id => nil, :order => 'price'})
      end

      it "with hash {:order => 3}" do
        Product.filter_params({:order => '3'}).should eql({
          :page => 1, :where => [], 
          :category_id => nil, :order => 'name'})
      end

      it "with hash array of type_values" do
        Product.filter_params({:where => [1,2,3,10]}).should eql({
          :page => 1, :where => [1,2,3,10], 
          :category_id => nil, :order => 'created_at'})
      end

    end

  end

  it 'is invalid without a name or description' do
    [:name, :description, :price, :image].each do |attribute|
      invalid_product = FactoryGirl.build(:product, attribute => nil)
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
    p = Product.new(:images => [FactoryGirl.build(:image)])
    p.image.should_not == Product.default_img
  end

  it "image is the first image from the Product images array" do
    img1 = FactoryGirl.build(:image)
    img2 = FactoryGirl.build(:image)
    p = Product.new(:images => [img1,img2])
    p.image.should == img1
  end

end