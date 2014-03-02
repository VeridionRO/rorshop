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

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
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
      products = FactoryGirl.create_list(:product1, 3)
      Product.stub(:favorite_products).and_return(products)
      get :welcome
      expect(assigns[:products]).to eql(products)
    end
  end

end
