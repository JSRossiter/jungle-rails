require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      category = Category.create(name: 'test')
      @product1 = category.products.create!(name: 'product 1', price: 100, quantity: 5)
      @product2 = category.products.create!(name: 'product 2', price: 100, quantity: 5)

      @order = Order.new(stripe_charge_id: 1)
      @order.line_items.new(product: @product1, quantity: 2, total_price: 100, item_price: 100)
      @order.total = 100
      @order.save!
      @product1.reload
      @product2.reload
    end
    it 'deducts quantity from products based on their line item quantities' do
      expect(@product1.quantity).to eql(3)
    end
    it 'does not deduct quantity from products that are not in the order' do
      expect(@product2.quantity).to eql(5)
    end
  end
end