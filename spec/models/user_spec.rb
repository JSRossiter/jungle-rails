require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before :each do
      @user = User.new(first_name: 'a', last_name: 'a', email: '1@1.com', password: 'test_password', password_confirmation: 'test_password')
    end

    it 'should return an error when password_confirmation is omitted' do
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end
    it 'should require password and password_confirmation to match' do
      @user.password_confirmation = 'not_test_password'
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'should create a user with valid inputs' do
      expect(@user).to be_valid
    end
    it 'should require emails to be unique, case insensitive' do
      @user.save
      user_b = User.new(first_name: 'b', last_name: 'b', email: '1@1.COM', password: 'test_password', password_confirmation: 'test_password')
      expect(user_b).to_not be_valid
      expect(user_b.errors.full_messages).to include("Email has already been taken")
    end
    it 'should return an error when missing email' do
      @user.email = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'should return an error when missing first_name' do
      @user.first_name = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'should return an error when missing last_name' do
      @user.last_name = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'should return an error when password is too short' do
      @user.password = 'five5'
      @user.password_confirmation = 'five5'
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    before :each do
      @user = User.create(first_name: 'a', last_name: 'a', email: '1@1.com', password: 'test_password', password_confirmation: 'test_password')
    end

    it 'should return user when provided correct credentials' do
      user = User.authenticate_with_credentials('1@1.com', 'test_password')
      expect(user).to eql(@user)
    end
    it 'should return false when provided incorrect password' do
      user = User.authenticate_with_credentials('1@1.com', 'not_test_password')
      expect(user).to eql(false)
    end
    it 'should return false when provided incorrect email' do
      user = User.authenticate_with_credentials('not@email.com', 'test_password')
      expect(user).to eql(false)
    end
    it 'should return user when provided email with different case characters' do
      user = User.authenticate_with_credentials('1@1.COM', 'test_password')
      expect(user).to eql(@user)
    end
    it 'should return user when provided email with white space after' do
      user = User.authenticate_with_credentials('1@1.com ', 'test_password')
      expect(user).to eql(@user)
    end
    it 'should return user when provided with white space before' do
      user = User.authenticate_with_credentials(' 1@1.com', 'test_password')
      expect(user).to eql(@user)
    end
  end

end
