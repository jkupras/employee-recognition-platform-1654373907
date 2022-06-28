require 'rails_helper'

RSpec.describe 'kudo spending', type: :system do
  let(:employee) { create(:employee) }
  let!(:employee_nr_2) { create(:employee) }
  let(:kudo) { build(:kudo) }

  before do
    create_list(:kudo, 9, { giver: employee, receiver: employee_nr_2 })
    sign_in employee
  end

  it 'changes the amount of kudos' do
    visit root_path
    click_link 'New Kudo'
    fill_in 'Title', with: kudo.title
    fill_in 'Content', with: kudo.content
    select employee_nr_2.email, from: 'kudo_receiver_id'
    select CompanyValue.last.title, from: 'kudo_company_value_id'
    click_button 'Create Kudo'
    expect(page).to have_content 'Kudo was successfully created.'
    expect(page).to have_content kudo.title
    expect(page).to have_content kudo.content
    expect(page).to have_content  "You don't have any available kudos to give"
    expect(page).to have_content  'The number of available kudos is 0'
    expect(Kudo.count).to equal 10
  end

  it 'spends only available for employee number of kudos' do
    visit root_path
    click_link 'New Kudo'
    fill_in 'Title', with: kudo.title
    fill_in 'Content', with: kudo.content
    select employee_nr_2.email, from: 'kudo_receiver_id'
    select employee.giver_kudos.last.company_value.title, from: 'kudo_company_value_id'
    click_button 'Create Kudo'
    visit new_kudo_path
    fill_in 'Title', with: kudo.title
    fill_in 'Content', with: kudo.content
    select employee_nr_2.email, from: 'kudo_receiver_id'
    select employee.giver_kudos.last.company_value.title, from: 'kudo_company_value_id'
    click_button 'Create Kudo'
    expect(page).to have_content '1 error prohibited this kudo from being saved'
    expect(page).to have_content 'Number of available kudos there are no available kudos to give'
  end
end
