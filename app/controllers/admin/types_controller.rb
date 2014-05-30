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
    if @type.save
      redirect_to polymorphic_path([:admin, @type]),
        :flash => { :success => 'Categoria a fost salvat' }
    else
      flash[:error] = 'Categoria nu a fost salvat'
      render action: 'new'
    end
  end

  def update
    @type = Type.find params[:id]
    remove_vals(@type.type_value_ids - params[:type][:type_value_ids].map(&:to_i))
    if @type.update(type_params)
      redirect_to polymorphic_path([:admin, @type]),
        :flash => {:success => 'Categoria a fost salvat'}
    else
      flash[:error] = 'Categoria nu a fost salvat'
      render action: 'edit'
    end
  end

  def remove_vals val_ids
    val_ids.each do |val_id|
      value = TypeValue.find(val_id)
      value.destroy
    end
  end

  private

    def type_params
      params.require(:type).permit(:name)
    end

end
