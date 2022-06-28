require 'rails_helper'

RSpec.describe 'the admin listing and deleting', type: :system do
  let(:admin) { create(:admin) }
  let!(:kudo) { create(:kudo) }

  before do
    sign_in admin
  end

  it 'listing kudos' do
    visit admins_authenticated_root_path
    click_link 'Kudos'
    expect(page).to have_content 'Log out'
    expect(page).to have_content 'Kudos'
    expect(page).to have_content 'Title'
    expect(page).to have_content kudo.title
    expect(page).to have_content 'Content'
    expect(page).to have_content kudo.content
    expect(page).to have_content 'Company Value'
    expect(page).to have_content kudo.company_value.title

    expect(page).to have_link 'Show'
    expect(page).to have_link 'Destroy'
  end

  it 'deleting kudos' do
    visit admins_authenticated_root_path
    click_link 'Kudos'
    click_link 'Destroy', match: :first
    expect(page).to have_content 'Kudo was successfully destroyed.'
  end
end
