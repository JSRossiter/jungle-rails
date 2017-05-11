class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category
  has_many :reviews

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

  def sold_out?
    self.quantity == 0
  end

  def rating
    rating = self.reviews.average(:rating)
    if rating
      round = (rating * 2).round.to_f / 2
    else
      rating
    end
  end

end
