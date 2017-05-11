class User < ActiveRecord::Base

  has_secure_password

  has_many :reviews

  validates :first_name, :email, presence: true
  validates :email, uniqueness: true

end
