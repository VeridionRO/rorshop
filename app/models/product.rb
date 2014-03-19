class Product < ActiveRecord::Base

  has_many :images

  after_initialize :add_image
  
  validates :name, :description, :image, presence: true

  @@default_img = {
    :title => "Imagine Default", 
    :uri => "default_img.jpg"
  }

  @@pagination = 10

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
    previous_product = Product.where("id < #{id}").order('id DESC').first
    next_product = Product.where("id > #{id}").first
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

  def self.get_page page
    Product.order('created_at DESC').limit(@@pagination).offset(page * 10)
  end

end