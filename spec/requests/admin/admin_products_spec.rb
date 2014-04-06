require 'spec_helper'

describe "Admin::Products" do
  describe "GET /admin/products" do
    it "works! (now write some real specs)" do
      get '/admin/products'
      response.status.should be(200)
    end
  end
end
