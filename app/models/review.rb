class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :product

  validates :rating, presence: true
  validates :rating, inclusion: { in: 1..5, message: "must be a number between 1 and 5" }
  validates :user, presence: true
  validates :product, presence: true

end
