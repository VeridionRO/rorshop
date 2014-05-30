class ProductsController < ApplicationController
  def index
    if params[:search] && params[:search].kind_of?(Array)
      query = params[:search].join(' ')
    else
      query = params[:search]
    end
    @search = Product.search do
      fulltext query do
        boost_fields :name => 2.0
      end
      paginate :page => params[:page], :per_page => 10
    end
    @results = @search.results
    @categories = Category.all
    @types = Type.all
  end

  def show
    @product = Product.find(params[:id])
    @product.get_neighbours
    @categories = Category.all
  end

  def welcome
    @search = Product.search do
      fulltext params[:search]
      order_by :updated_at, :desc
      paginate :page => params[:page], :per_page => 10
    end
    @results = @search.results
    @categories = Category.all
  end

  def filter

  end
end