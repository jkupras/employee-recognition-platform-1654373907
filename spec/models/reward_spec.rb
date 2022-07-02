require 'rails_helper'

RSpec.describe Reward, type: :model do
  let!(:reward) { create(:reward) }

  describe '#title' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe '#description' do
    it { is_expected.to validate_presence_of(:description) }
  end

  describe '#price' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(1) }
  end
end
