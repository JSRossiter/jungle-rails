class User < ActiveRecord::Base

  has_secure_password

  has_many :reviews

  validates :first_name, :last_name, :email, :password_confirmation, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials (email, password)
    user = User.where("lower(email) = ?", email.downcase.strip).first
    return false unless user
    user.authenticate(password)
  end


end
