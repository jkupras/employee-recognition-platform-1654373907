require 'rails_helper'

RSpec.describe 'the admin signin process', type: :system do
  let!(:admin) { create(:admin) }

  it 'signs me in' do
    visit '/admins'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log in'
    expect(page).to have_content 'Log out'
  end
end
