require 'rails_helper'

RSpec.describe 'the signup and signin process', type: :system do
  let(:employee) { build(:employee) }

  it 'signs me in' do
    visit root_path
    click_link 'Sign up', match: :first
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    fill_in 'Password confirmation', with: employee.password
    click_button 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully'

    click_link 'Log out'
    expect(page).to have_content 'Log in'

    click_link 'Sign in', match: :first
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end
end
