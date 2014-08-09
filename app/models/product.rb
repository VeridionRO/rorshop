class Product < ActiveRecord::Base

  has_and_belongs_to_many :type_values, :join_table => "products_type_values"
  has_many :images, dependent: :destroy

  after_save :index_product

  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, :description, :price, presence: true

  attr_accessor :neighbours

  @@default_img = {
    :title => "Imagine Default", 
    :uri => "default_img.jpg"
  }

  searchable do
    text :name, :description
    time :updated_at
    text :type_values do
      type_values.map { |v| v.value }
    end
    autocomplete :product_name, :using => :name
  end

  PAG = 9

  def get_neighbours
    raise ProductException::CannotHaveNeighbours, 
      "Unsaved product cannot have neighbours" unless id
    previous_product = Product.where('id < ?', id).order('id DESC').first
    next_product = Product.where('id > ?', id).first
    @neighbours = {:previous => previous_product, :next => next_product}
  end

  def neighbour which
    get_neighbours unless neighbours
    @neighbours[which] if @neighbours && @neighbours[which]
  end

  ### Class methods ###
  def self.favorite_products
    Product.order('id DESC')
           .limit(9)
  end

  def self.default_img
    @@default_img
  end

  def self.get_page params = {}
    params = self.filter_params params
    self.get_results params
  end

  def self.get_results params
    products = Product.order("products.#{params[:order]} DESC")
    products = products.joins(:type_values)
                       .where(type_values: {id: params[:where]})
                       .group("products.id")
                       .having('COUNT("product.id")=?', 
                          params[:where].count) unless params[:where].empty?
    products.limit(PAG)
            .offset((params[:page] - 1) * PAG)
            .to_a
  end

  def self.filter_params params
    page = params[:page] ? params[:page].to_i : 1
    category_id = params[:category_id] ? params[:category_id].to_i : nil
    where = params[:where] ? params[:where] : []
    order = 'created_at'
    if params[:order] == '2'
      order = 'price'
    elsif params[:order] == '3'
      order = 'name'
    end
    {:page => page, :category_id => category_id, 
      :where => where, :order => order}
  end

  def self.get_page_array
    count = Product.count
    return 1..count/10
  end

  def index_product
    SearchSuggestion.index_product self
  end

end