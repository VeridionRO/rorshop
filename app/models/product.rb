class Product < ActiveRecord::Base

  has_many :images

  after_initialize :add_image
  
  validates :name, :description, :image, presence: true

  @@default_img = {
    :title => "Imagine Default", 
    :uri => "default_img.jpg"
  }

  attr_accessor :image

  def self.favorite_products
    Product.order('id DESC').limit(9)
  end

  def self.default_img
    @@default_img
  end

  def add_image
    debugger
    if images.empty?
      @image = @@default_img
    else
      @image = images[0]
    end
  end

end