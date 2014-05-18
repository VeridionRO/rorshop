class Image < ActiveRecord::Base
  # validates :product, presence: true
  # validates_uniqueness_of :product, 
  #   message: "product_id and default_image must be unique",
  #   scope: :default_image

  belongs_to :product
  has_attached_file :image
  do_not_validate_attachment_file_type :image

end