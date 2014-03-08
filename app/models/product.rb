class Product < ActiveRecord::Base
  validates :name, :description, presence: true
  has_many :images
  has_one :image

  after_initialize :assign_default_image

  @@default_img = nil

  attr_accessor :default_image

  def self.favorite_products
    Product.order('id DESC').limit(9)
  end

  def self.default_img
    if !@@default_img
      @@default_img = Image.new(:title => "Imagine Default", 
        :uri => "default_img.jpg", :product_id => 0)
    end
    @@default_img
  end

  def assign_default_image
    if !image_id
      @default_image = Product.default_img
    end
  end

end