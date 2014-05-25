class Admin::TypesController < ApplicationController
  def index
    @search = Type.search do
      fulltext params[:search]
      order_by :updated_at, :desc
      paginate :page => params[:page], :per_page => 10
    end
    @results = @search.results
  end

  def show
    @type = Type.find params[:id]
  end

  def edit
    @type = Type.find params[:id]
  end

  def new
    @type = Type.new
  end

end
