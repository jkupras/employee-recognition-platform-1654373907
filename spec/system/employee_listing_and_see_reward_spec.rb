require 'rails_helper'

RSpec.describe 'the employee', type: :system do
  let(:employee) { create(:employee) }
  let!(:reward) { create(:reward) }

  before do
    sign_in employee
  end

  it 'listing rewards' do
    visit root_path
    click_link 'Rewards'
    expect(page).to have_content 'Title'
    expect(page).to have_content reward.title
    expect(page).to have_content 'Price'
    expect(page).to have_content reward.price
    expect(page).to have_link 'Show'
  end

  it 'see reward details' do
    visit root_path
    click_link 'Rewards'
    click_link 'Show', match: :first
    expect(page).to have_content 'Title'
    expect(page).to have_content reward.title
    expect(page).to have_content 'Description'
    expect(page).to have_content reward.description
    expect(page).to have_content 'Price'
    expect(page).to have_content reward.price
  end
end
