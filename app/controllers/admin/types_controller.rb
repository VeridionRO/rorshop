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

  def create
    @type = Type.new(type_params)
    @types = Type.all
    if @type.save
      redirect_to polymorphic_path([:admin, @type]),
        :flash => { :success => 'Categoria a fost salvat' }
    else
      render action: 'new'
    end
  end

  def update
    @type = Type.find params[:id]
    @types = Type.all
    if @type.update(type_params)
      redirect_to polymorphic_path([:admin, @type]),
        :flash => {:success => 'Categoria a fost salvat'}
    else
      render action: 'edit'
    end
  end

  private

    def type_params
      params.require(:type).permit(:name, :type => [:type_value_ids => []])
    end

end
