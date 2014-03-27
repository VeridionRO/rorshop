require 'spec_helper'

describe ProductsController do

  let!(:categories) { [Category.new] }
  let!(:types) { [Type.new] }

  before(:each) do
    Category.stub(:all).and_return(categories)
    Type.stub(:all).and_return(types)
  end

  describe "GET 'index'" do

    it "returns http success" do
      get :index
      response.should be_success
    end

    it "renders the welcome template" do
      get :index
      response.should render_template(:index)
    end

    it "should call get_page" do
      Product.should_receive(:get_page).with({:page => '1', :category_id => '1'})
      get :index, :page => 1, :category_id => 1
    end

    it "should call get_page" do
      Product.should_receive(:get_page).with({:page => '1', :category_id => '1'})
      get :index, :page => 1, :category_id => 1
    end

    it "should call Category.all" do
      Product.stub(:get_page)
      Category.should_receive(:all)
      get :index
    end

    it "should call Category.all" do
      Product.stub(:get_page)
      Type.should_receive(:all)
      get :index
    end

    describe "should assign" do

      let!(:products) { [Product.new] }

      before(:each) do
        Product.stub(:get_page).and_return(products)
        get :index
      end

      it "the @products variable to the view" do
        expect(assigns[:products]).to eql(products)
      end

      it "the @categories variable to the view" do
        expect(assigns[:categories]).to eql(categories)
      end

      it "the @types variable to the view" do
        expect(assigns[:types]).to eql(types)
      end
      
    end

  end

  describe "GET 'welcome'" do
    let(:products) { FactoryGirl.build_list(:product, 3) }

    before(:each) do
      Product.stub(:favorite_products).and_return(products)
    end

    it "returns http success" do
      get :welcome
      response.should be_success
    end

    it "renders the welcome template" do
      get :welcome
      response.should render_template(:welcome)
    end

    it "should call the model method favorite_products" do
      Product.should_receive(:favorite_products)
      get :welcome
    end

    it "should call the model method favorite_products" do
      Category.should_receive(:all)
      get :welcome
    end

    it "should assign @products to the welcome view" do
      get :welcome
      expect(assigns[:products]).to eql(products)
    end

    it "should assign @categories to the welcome view" do
      get :welcome
      expect(assigns[:categories]).to eql(categories)
    end
  end

  describe "GET '/product/:id'" do

    before(:each) do
      @product = FactoryGirl.create(:product_with_images)
      Product.stub(:find).and_return(@product)
      @product.stub(:get_neighbours).and_return({})
    end

    it "success" do
      get :show, :id => @product.id
      response.should be_success
    end

    it "renders the index template" do
      get :show, :id => @product.id
      response.should render_template(:show)
    end

    it "calls the Product.find method" do
      Product.should_receive(:find)
      get :show, :id => @product.id
    end

    it "calls the Product.get_neighbours method" do
      @product.should_receive(:get_neighbours)
      get :show, :id => @product.id
    end

    it "calls the Product.find method" do
      Category.should_receive(:all)
      get :show, :id => @product.id
    end

    it "assigns the @product variable to the template" do
      get :show, :id => @product.id
      expect(assigns[:product]).to eql(@product)
    end

    it "assigns the @categories variable to the template" do
      get :show, :id => @product.id
      expect(assigns[:categories]).to eql(categories)
    end

  end

end