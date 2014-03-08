class Image < ActiveRecord::Base
  validates :uri, :title, :product_id, presence: true
  belongs_to :product
  validates_uniqueness_of :product_id, :message => "product_id and default_img must be unique", scope: :default_img
end
