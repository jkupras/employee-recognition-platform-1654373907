class Kudo < ApplicationRecord
  belongs_to :giver, class_name: 'Employee'
  belongs_to :receiver, class_name: 'Employee'
  belongs_to :company_value
  validates :title, presence: true
  validates :content, presence: true
  validate :number_of_available_kudos_cannot_be_less_then_zero

  def number_of_available_kudos_cannot_be_less_then_zero
    return unless giver.number_of_available_kudos.negative?

    errors.add(:number_of_available_kudos, 'there are no available kudos to give')
  end
end
