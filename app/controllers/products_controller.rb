class ProductsController < ApplicationController
  def index
    @products = Product.get_page({
      :page => params['page'], 
      :category_id => params['category_id'],
      :where => params['where'],
      :order => params['order']})
    # debugger
    @categories = Category.all
    @types = Type.all
  end

  def show
    @product = Product.find(params[:id])
    @product.get_neighbours
    @categories = Category.all
  end

  def welcome
    @products = Product.favorite_products
    @categories = Category.all
  end

  def filter

  end
end