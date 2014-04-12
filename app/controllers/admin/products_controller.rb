class Admin::ProductsController < ApplicationController
  def index
    @products = Product.get_page params
  end

  def show
    @product = Product.find params[:id]
  end

  def edit
    @product = Product.find params[:id]
  end

  def new
    @product = Product.new
  end  

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to polymorphic_path([:admin, @product]),
        :flash => { :success => 'Produsul a fost salvat' }
    else
      render action: "edit"
    end
  end

  def update
    @product = Product.find params[:id]
    if @product.update(product_params)
      redirect_to polymorphic_path([:admin, @product]),
        :flash => { :success => 'Produsul a fost salvat' }
    else
      render action: "edit"
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
      params.require(:product).permit(:name, :description, :price)
    end

end
