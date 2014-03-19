class ProductsController < ApplicationController
  def index
    @products = Product.get_page 0
  end

  def show
    @product = Product.find(params[:id])
    @product.get_neighbours
  end

  def welcome
    @products = Product.favorite_products
  end
end