require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before :each do
      category = Category.new(name: 'a')
      @product = category.products.new(name: 'Bike', price: 100, quantity: 10)
    end

    it 'should create a new product with valid inputs' do
      expect(@product).to be_valid
    end
    it 'should return an error when missing name' do
      @product.name = nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it 'should return an error when missing price' do
      @product.price_cents = nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it 'should return an error when missing quantity' do
      @product.quantity = nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'should return an error when missing category' do
      @product.category = nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end

end
