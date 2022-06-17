require 'rails_helper'

RSpec.describe 'admin menage employee', type: :system do
  let(:admin) { create(:admin) }
  let!(:employee) { create(:employee) }

  before do
    sign_in admin
  end

  it 'listing employee' do
    visit admins_authenticated_root_path
    click_link 'Employees list'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Number of available kudos'
    expect(page).to have_content employee.email
    expect(page).to have_content employee.number_of_available_kudos
    expect(page).to have_link 'Edit'
    expect(page).to have_link 'Destroy'
  end

  context 'when editing employee' do
    it 'work with password change' do
      visit admins_authenticated_root_path
      click_link 'Employees list'
      click_link 'Edit'
      expect(page).to have_field('Email', with: employee.email)
      expect(page).to have_content 'Password'
      expect(page).to have_content 'Password confirmation'
      expect(page).to have_field('Number of available kudos', with: employee.number_of_available_kudos)
      expect(page).to have_button 'Update Employee'
      fill_in 'Email', with: 'new1@email.com'
      fill_in 'Number of available kudos', with: 1
      fill_in 'Password:', with: 'newpassword'
      fill_in 'Password confirmation', with: 'newpassword'
      click_button 'Update Employee'
      expect(page).to have_content 'Employee was successfully updated.'
    end

    it 'work without password change' do
      visit admins_authenticated_root_path
      click_link 'Employees list'
      click_link 'Edit'
      fill_in 'Email', with: 'new2@email.com'
      fill_in 'Number of available kudos', with: 2
      click_button 'Update Employee'
      expect(page).to have_content 'Employee was successfully updated.'
    end
  end

  it 'deleting employee' do
    visit admins_authenticated_root_path
    click_link 'Employees list'
    click_link 'Destroy', match: :first
    expect(page).to have_content 'Employee was successfully destroyed.'
  end
end
