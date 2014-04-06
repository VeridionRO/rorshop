require 'spec_helper'

describe Admin::ProductsController do

  describe "GET 'index'" do

    let!(:categories) { [Category.new] }
    
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

end
