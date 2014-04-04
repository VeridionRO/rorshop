class Product < ActiveRecord::Base

  has_and_belongs_to_many :categories, :join_table => "categories_products"
  has_and_belongs_to_many :type_values, :join_table => "products_type_values"
  has_many :images
  scope :filter_type_values, ->(value_id){ 
    includes(:type_values).where(:type_values => {:id => value_id})
  }

  after_initialize :add_image
  
  validates :name, :description, :image, presence: true

  @@default_img = {
    :title => "Imagine Default", 
    :uri => "default_img.jpg"
  }

  PAG = 9

  attr_accessor :image, :neighbours
  
  def add_image
    if images.empty?
      @image = @@default_img
    else
      @image = images[0]
    end
  end

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
    products = Product.order('products.created_at DESC')
    products = products.joins(:categories)
                       .where('category_id = ?', params[:category_id]) if params[:category_id]
    params[:where].each do |value_id|
      products = products.merge(Product.filter_type_values(value_id))
    end
    products.limit(PAG)
            .offset((params[:page] - 1) * PAG)
            .to_a
  end

  def self.filter_params params
    page = params[:page] ? params[:page].to_i : 1
    category_id = params[:category_id] ? params[:category_id].to_i : nil
    where = params[:where] ? params[:where] : []
    {:page => page, :category_id => category_id, :where => where}
  end

end