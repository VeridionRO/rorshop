class Admin::ProductsController < ApplicationController
  def index
    @params = Product.filter_params params
    @products = Product.get_page params
    @pages = Product.get_page_array
  end

  def show
    @product = Product.find params[:id]
  end

  def edit
    @product = Product.find params[:id]
    @product.images.build
    @types = Type.all
  end

  def new
    @product = Product.new
    @product.images.build
    @types = Type.all
  end

  def create
    @types = Type.all
    @product = Product.new(product_params)
    if @product.save!
      redirect_to polymorphic_path([:admin, @product]),
        :flash => { :success => 'Produsul a fost salvat' }
    else
      render action: 'new'
    end
  end

  def update
    @product = Product.find params[:id]
    @types = Type.all
    if params[:product][:images]
      @product.images << params[:product][:images]
    end
    if @product.update(product_params)
      redirect_to polymorphic_path([:admin, @product]),
        :flash => { :success => 'Produsul a fost salvat' }
    else
      render action: 'edit'
    end
  end

  def destroy
    @product = Product.find params[:id]
    if @product.destroy
      redirect_to admin_products_path, :flash => { :success => 'Produsul a fost sters' }
    else

    end
  end

  private

    def product_params
      params.require(:product).permit(:name, :description, :price, images_attributes: [:image])
    end

end
