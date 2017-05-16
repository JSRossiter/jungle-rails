require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

  scenario "User is redirected to home page after successful login" do
    @user = User.create(first_name: 'a', last_name: 'a', email: '1@1.com', password: 'test_password', password_confirmation: 'test_password')

    visit root_path
    click_on 'Login'

    fill_in 'Email', with: '1@1.com'
    fill_in 'Password', with: 'test_password'
    click_button 'Login'

    expect(page).to have_content('Signed in as a')
  end


end
