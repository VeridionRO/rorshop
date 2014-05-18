require 'spec_helper'

describe Admin::ProductsController do

  describe "GET 'index'" do

    let(:products) { [Product.new] }

    before do
      Product.stub(:get_page).and_return(products)
    end

    it "returns http success" do
      get :index
      response.should be_success
    end

    it "calls get_page" do
      Product.should_receive(:get_page)
      get :index
    end

    it "renders index template" do
      get :index
      response.should render_template(:index)
    end

    it "renders index template" do
      get :index
      expect(assigns[:products]).to eql(products)
    end

  end

  describe "GET 'show'" do

    let(:product) { FactoryGirl.create(:product) }

    before do
      Product.stub(:find).and_return(product)
    end

    it "returns http success" do
      get :show, :id => product.id
      response.should be_success
    end

    it "calls find" do
      Product.should_receive(:find)
      get :show, :id => product.id
    end

    it "renders index template" do
      get :show, :id => product.id
      response.should render_template(:show)
    end

    it "renders index template" do
      get :show, :id => product.id
      expect(assigns[:product]).to eql(product)
    end

  end

  describe "GET 'edit'" do

    let(:product) { FactoryGirl.create(:product) }
    let(:types) { FactoryGirl.create_list(:type, 3) }

    before do
      Product.stub(:find).and_return(product)
      Type.stub(:all).and_return(types)
    end

    it "returns http success" do
      get :edit, :id => product.id
      response.should be_success
    end

    it "Product calls find" do
      Product.should_receive(:find)
      get :edit, :id => product.id
    end

    it "renders index template" do
      get :edit, :id => product.id
      response.should render_template(:edit)
    end

    it "renders index template" do
      get :edit, :id => product.id
      expect(assigns[:product]).to eql(product)
    end

    it "Type calls all" do
      Type.should_receive(:all)
      get :edit, :id => product.id
    end

    it "renders index template" do
      get :edit, :id => product.id
      expect(assigns[:types]).to eql(types)
    end

  end

  describe "GET 'new'" do

    let(:product) { product = Product.new }

    before do
      Product.stub(:new).and_return(product)
    end

    it "returns http success" do
      get :new
      response.should be_success
    end

    it "calls find" do
      Product.should_receive(:new)
      get :new
    end

    it "renders new template" do
      get :new
      response.should render_template(:new)
    end

    it "assigns the product to the view" do
      get :new
      expect(assigns[:product]).to eql(product)
    end

  end
  
end
