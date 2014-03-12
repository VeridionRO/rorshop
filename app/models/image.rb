class Image < ActiveRecord::Base
  belongs_to :product
  validates :uri, :title, :product, presence: true
  validates_uniqueness_of :product, 
    :message => "product_id and default_image must be unique", 
    scope: :default_image
end