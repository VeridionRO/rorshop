class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create
  validates :first_name, :last_name, :email, :password, presence: true
  validates_uniqueness_of :email

  def name
    first_name + ' ' + last_name
  end

end