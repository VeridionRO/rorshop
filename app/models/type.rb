class Type < ActiveRecord::Base

  validates :name, presence: true, length: {maximum: 255}
  has_many :type_values

  searchable do
    text :name
    time :updated_at
  end

  PAG = 9

  def to_s
    'test'
  end

  def self.get_page
    params = self.params params
    types = Type.limit(PAG)
    .offset((params[:page] - 1) * PAG)
    .to_a
    types
  end

  def self.params params = {}
    page = (params && params[:page] ? params[:page] : 1)
    {:page => page}
  end

  def self.get_page_array
    count = self.count
    return 1..count/10
  end

end
