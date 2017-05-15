class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_save :adjust_quantities

  private

  def adjust_quantities
    self.line_items.all.each do |item|
      product = Product.find_by(id: item.product_id)
      product.quantity -= item.quantity
      product.save
    end
  end


end
