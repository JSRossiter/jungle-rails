require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should create a new product with valid inputs' do
      category = Category.new(name: 'a')
      product = category.products.new(name: 'Bike', price: 100, quantity: 10)
      expect(product).to be_valid
    end
    it 'should return an error when missing name' do
      category = Category.new(name: 'a')
      product = category.products.new(price: 100, quantity: 10)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end
    it 'should return an error when missing price' do
      category = Category.new(name: 'a')
      product = category.products.new(name: 'Bike', quantity: 10)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end
    it 'should return an error when missing quantity' do
      category = Category.new(name: 'a')
      product = category.products.new(name: 'Bike', price: 100)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'should return an error when missing category' do
      product = Product.new(name: 'Bike', price: 100, quantity: 10)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end

end
