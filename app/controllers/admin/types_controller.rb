class Admin::TypesController < ApplicationController
  def index
    @types = Type.all
    @params = Type.params
    @pages = Type.get_page_array
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
