require 'rails_helper'

RSpec.describe 'kudo crud', type: :system do
  let(:employee) { create(:employee) }
  let!(:employee_nr_2) { create(:employee) }
  let(:kudo) { build(:kudo) }

  before do
    sign_in employee
  end

  it 'create show update destroy kudo' do
    visit root_path
    click_link 'New Kudo'
    fill_in 'Title', with: kudo.title
    fill_in 'Content', with: kudo.content
    select employee_nr_2.email, from: 'kudo_receiver_id'
    click_button 'Create Kudo'
    expect(page).to have_content 'Kudo was successfully created.'
    expect(page).to have_content kudo.title
    expect(page).to have_content kudo.content

    click_link 'Show', match: :first
    expect(page).to have_content kudo.title
    expect(page).to have_content kudo.content

    click_link 'Back'
    click_link 'Edit', match: :first
    expect(page).to have_content 'Editing Kudo'
    fill_in 'Title', with: 'Title after edit'
    click_button 'Update Kudo'
    expect(page).to have_content 'Title after edit'
    expect(page).to have_content 'Kudo was successfully updated.'

    visit root_path
    click_link 'Destroy', match: :first
    expect(page).to have_content 'Kudo was successfully destroyed.'
  end
end
