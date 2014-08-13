class Image < ActiveRecord::Base
  belongs_to :product
  has_attached_file :image, 
    :default_url => "/assets/default_img.jpg", 
    :styles => { :medium => "210x210>", :thumb => "60x60>" }
  do_not_validate_attachment_file_type :image

  def self.default_image
    return self.new
  end

end