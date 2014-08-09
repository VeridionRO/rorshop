class TypeValue < ActiveRecord::Base

  belongs_to :type
  has_and_belongs_to_many :products, :join_table => "products_type_values"
  validates :type, :value, presence: true
  
end
