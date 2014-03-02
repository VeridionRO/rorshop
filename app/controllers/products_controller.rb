class ProductsController < ApplicationController
  def index
  end

  def show
  end

  def welcome
  	@products = Product.favorite_products
  end
end