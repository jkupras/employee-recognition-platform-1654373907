require 'rails_helper'

RSpec.describe 'admin menage rewards', type: :system do
  let(:admin) { create(:admin) }
  let!(:reward) { create(:reward) }
  let(:reward2) { attributes_for(:reward) }
  let(:reward3) { attributes_for(:reward) }

  before do
    sign_in admin
  end

  it 'listing rewards' do
    visit admins_authenticated_root_path
    click_link 'Rewards'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.description
    expect(page).to have_content reward.price
    expect(page).to have_link 'Edit'
    expect(page).to have_link 'Destroy'
    expect(page).to have_link 'New reward'
  end

  it 'creating reward' do
    visit admins_authenticated_root_path
    click_link 'Reward'
    click_link 'New reward'
    fill_in 'Title', with: reward2[:title]
    fill_in 'Description', with: reward2[:description]
    fill_in 'Price', with: reward2[:price]
    click_button 'Create Reward'
    expect(page).to have_content 'Reward was successfully created.'
    expect(page).to have_content reward2[:title]
    expect(page).to have_content reward2[:description]
    expect(page).to have_content reward2[:price]
  end

  it 'editing reward' do
    visit admins_authenticated_root_path
    click_link 'Rewards'
    click_link 'Edit'
    fill_in 'Title', with: reward3[:title]
    click_button 'Update Reward'
    expect(page).to have_content 'Reward was successfully updated.'
    expect(page).not_to have_content reward.title
    expect(page).to have_content reward3[:title]
  end

  it 'deleting reward' do
    visit admins_authenticated_root_path
    click_link 'Reward'
    click_link 'Destroy', match: :first
    expect(page).to have_content 'Reward was successfully destroyed.'
  end
end
