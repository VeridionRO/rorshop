class ProductsController < ApplicationController
  def index
  end

  def show
    @product = Product.find(params[:id])
  end

  def welcome
    @products = Product.favorite_products
  end
end