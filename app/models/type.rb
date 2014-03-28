class Type < ActiveRecord::Base

  validates :name, presence: true, length: {maximum: 255}
  has_many :type_values

end
