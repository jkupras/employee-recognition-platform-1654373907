class Order < ApplicationRecord
  belongs_to :employee
  belongs_to :reward
  validate :number_of_available_points_is_to_low
  validates :amount, presence: true

  def number_of_available_points_is_to_low
    return unless employee.available_points.negative?

    errors.add(:available_points, 'are not enough to buy this reward')
  end
end
