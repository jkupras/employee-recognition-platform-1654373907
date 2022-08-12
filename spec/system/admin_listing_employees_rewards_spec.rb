require 'rails_helper'

RSpec.describe 'admin listing employees rewards', type: :system do
  let(:admin) { create(:admin) }
  let(:employee) { create(:employee) }
  let!(:order) { create(:order, employee: employee) }

  before do
    sign_in admin
  end

  it 'listing all employees rewards' do
    visit admins_authenticated_root_path
    click_link 'Employees rewards list'
    expect(page).to have_content 'Title'
    expect(page).to have_content 'Description'
    expect(page).to have_content 'Price'
    expect(page).to have_content 'Purchase time'
    expect(page).to have_content 'Employee email'
    expect(page).to have_content order.reward.title
    expect(page).to have_content order.reward.description
    expect(page).to have_content order.amount
    expect(page).to have_content order.created_at
    expect(page).to have_content employee.email
  end

  it 'listing employee rewards' do
    visit admins_authenticated_root_path
    click_link 'Employees'
    click_link 'Rewards list'
    expect(page).to have_content 'Title'
    expect(page).to have_content 'Description'
    expect(page).to have_content 'Price'
    expect(page).to have_content 'Purchase time'
    expect(page).to have_content 'Employee email'
    expect(page).to have_content order.reward.title
    expect(page).to have_content order.reward.description
    expect(page).to have_content order.amount
    expect(page).to have_content order.created_at
    expect(page).to have_content employee.email
  end
end
