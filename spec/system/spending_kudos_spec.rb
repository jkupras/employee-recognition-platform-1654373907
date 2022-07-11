require 'rails_helper'

RSpec.describe 'kudo spending', type: :system do
  let(:employee) { create(:employee, number_of_available_kudos: 1) }
  let!(:employee_nr_2) { create(:employee) }
  let(:kudo) { build(:kudo) }

  before do
    create(:company_value)
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
    expect(Kudo.count).to equal 1
  end

  it 'spends only available for employee number of kudos' do
    employee.number_of_available_kudos = 0
    employee.save!

    visit new_kudo_path
    fill_in 'Title', with: kudo.title
    fill_in 'Content', with: kudo.content
    select employee_nr_2.email, from: 'kudo_receiver_id'
    select CompanyValue.last.title, from: 'kudo_company_value_id'
    click_button 'Create Kudo'
    expect(page).to have_content '1 error prohibited this kudo from being saved'
    expect(page).to have_content 'Number of available kudos there are no available kudos to give'
  end

  it 'increase number of points available for kudo receiver' do
    visit new_kudo_path
    fill_in 'Title', with: kudo.title
    fill_in 'Content', with: kudo.content
    select employee_nr_2.email, from: 'kudo_receiver_id'
    select CompanyValue.last.title, from: 'kudo_company_value_id'
    click_button 'Create Kudo'
    expect(Kudo.last.receiver.available_points).to eq 1
  end

  it 'delete kudo reduce number of points available for kudo receiver' do
    create(:kudo)
    visit new_kudo_path
    fill_in 'Title', with: kudo.title
    fill_in 'Content', with: kudo.content
    select employee_nr_2.email, from: 'kudo_receiver_id'
    select CompanyValue.last.title, from: 'kudo_company_value_id'
    click_button 'Create Kudo'
    expect(Kudo.last.receiver.available_points).to eq 1
    visit root_path
    click_link 'Destroy', match: :first
    expect(Kudo.last.receiver.available_points).to eq 0
  end
end
