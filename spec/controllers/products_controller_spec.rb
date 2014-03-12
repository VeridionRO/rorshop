require 'spec_helper'

describe ProductsController do

  before(:each) do
    Product.stub(:favorite_products)
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

  end

  describe "GET 'welcome'" do
    it "returns http success" do
      get 'welcome'
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

    it "should assign products to the welcome view" do
      products = FactoryGirl.build_list(:valid_product, 3)
      Product.stub(:favorite_products).and_return(products)
      get :welcome
      expect(assigns[:products]).to eql(products)
    end
  end

  describe "GET '/product/:id'" do

    before(:each) do
      @product = FactoryGirl.create(:product_with_images)
    end

    it "GET '/product/:id'" do
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

    it "assigns the @product variable to the template" do
      Product.stub(:find).and_return(@product)
      get :show, :id => @product.id
      expect(assigns[:product]).to eql(@product)
    end
    
  end

end
