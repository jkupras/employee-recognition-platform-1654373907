require 'rails_helper'

RSpec.describe 'the employee', type: :system do
  let(:employee) { create(:employee) }
  let(:admin) { create(:admin) }
  let!(:order) { create(:order, employee: employee) }

  before do
    sign_in employee
  end

  it 'listing their bought rewards' do
    visit root_path
    click_link 'My rewards'
    expect(page).to have_content 'Title'
    expect(page).to have_content order.reward.title
    expect(page).to have_content 'Description'
    expect(page).to have_content order.reward.description
    expect(page).to have_content 'Purchase time'
    expect(page).to have_content order.created_at
    expect(page).to have_content 'Price'
    expect(page).to have_content order.amount
  end

  it 'sees his order reward price, which is independent of the reward price after the updated by the admin' do
    visit root_path
    click_link 'My rewards'
    expect(page).to have_content 'Price'
    expect(page).to have_content order.amount
    click_link 'Log out'
    sign_in admin
    visit '/admins'
    click_link 'Rewards'
    click_link 'Edit'
    fill_in 'Price', with: 9.99
    click_button 'Update Reward'
    click_link 'Log out'
    sign_in employee
    visit root_path
    click_link 'My rewards'
    expect(page).to have_content 'Price'
    expect(page).not_to have_content order.reward.price
    expect(page).to have_content order.amount
  end
end
