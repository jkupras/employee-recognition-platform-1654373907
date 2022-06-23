require 'rails_helper'

RSpec.describe 'admin menage company values', type: :system do
  let(:admin) { create(:admin) }
  let!(:company_value) { create(:company_value) }

  before do
    sign_in admin
  end

  it 'listing company values' do
    visit admins_authenticated_root_path
    click_link 'Company values'
    expect(page).to have_content 'Title'
    expect(page).to have_content company_value.title
    expect(page).to have_link 'Edit'
    expect(page).to have_link 'Destroy'
    expect(page).to have_link 'New company value'
  end

  it 'creating company value' do
    visit admins_authenticated_root_path
    click_link 'Company values'
    click_link 'New company value'
    fill_in 'Title', with: 'Pride'
    click_button 'Create Company value'
    expect(page).to have_content 'Company value was successfully created.'
    expect(page).to have_content company_value.title
    expect(page).to have_content 'Pride'
  end

  it 'editing company value' do
    visit admins_authenticated_root_path
    click_link 'Company values'
    click_link 'Edit'
    fill_in 'Title', with: 'Pride'
    click_button 'Update Company value'
    expect(page).to have_content 'Company value was successfully updated.'
    expect(page).not_to have_content company_value.title
    expect(page).to have_content 'Pride'
  end

  it 'deleting company values' do
    visit admins_authenticated_root_path
    click_link 'Company values'
    click_link 'Destroy', match: :first
    expect(page).to have_content 'Company value was successfully destroyed.'
  end
end
