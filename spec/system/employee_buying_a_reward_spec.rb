require 'rails_helper'

RSpec.describe 'the employee', type: :system do
  let!(:reward) { create(:reward, price: 5.55) }

  context 'with enough number of points' do
    let(:employee) { create(:employee, available_points: 10) }

    before do
      sign_in employee
    end

    it 'can buy reward' do
      visit root_path
      click_link 'Rewards'
      expect(page).to have_content 'The number of available points is 10.0'
      click_link 'Buy'
      expect(page).to have_content 'The reward has been bought'
      expect(page).to have_content 'The number of available points is 4.45'
    end
  end

  context 'without enough number of points' do
    let(:employee) { create(:employee, available_points: 1) }

    before do
      sign_in employee
    end

    it "can't buy reward" do
      visit root_path
      click_link 'Rewards'
      expect(page).to have_content 'The number of available points is 1.0'
      click_link 'Buy'
      expect(page).to have_content 'Available points are not enough to buy this reward'
      expect(page).to have_content 'The number of available points is 1.0'
    end
  end
end
