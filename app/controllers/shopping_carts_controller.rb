class ShoppingCartsController < ApplicationController
  before_filter :extract_shopping_cart

  def create
    @product = Product.find(params[:product_id])
    @shopping_cart.add(@product, @product.price,params[:quantity].to_i)
    redirect_to shopping_cart_path(@shopping_cart),
      :flash => {:success => "Succes: Ati adugat <b><a href=\"#{product_path(@product)}\">#{@product.name}</a></b> la cosul dumneavoastra de cumparaturi!"}
  end

  def show
    @types = Type.all
  end

  def remove_item
    @product = Product.find(params[:product_id])
    if @shopping_cart.remove(@product, @shopping_cart.quantity_for(@product))
      redirect_to shopping_cart_path(@shopping_cart),
        :flash => {:warning => "Notificare: Ati sters <b><a href=\"#{product_path(@product)}\">#{@product.name}</a></b> din cosul dumneavoastra de cumparaturi!"}
    else

    end
    @types = Type.all
  end

  def order
    @types = Type.all
  end

end