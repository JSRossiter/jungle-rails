require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should create a new product with valid inputs' do
      @category = Category.new(name: 'a')
      @product = @category.products.new(name: 'Bike', price: 100, quantity: 10)
      @product.save
      expect(Product.count).to eql(1)
    end
  end

end
