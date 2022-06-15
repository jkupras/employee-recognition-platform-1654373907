class Kudo < ApplicationRecord
  belongs_to :giver, class_name: 'Employee'
  belongs_to :receiver, class_name: 'Employee'
  validates :title, presence: true
  validates :content, presence: true
  validate :number_of_available_kudos_cannot_be_less_then_zero
  before_create :reduce_number_of_available_kudos
  after_destroy :increase_number_of_available_kudos

  def number_of_available_kudos_cannot_be_less_then_zero
    return unless giver.number_of_available_kudos <= 0

    errors.add(:number_of_available_kudos, 'there are no available kudos to give')
  end

  def reduce_number_of_available_kudos
    giver.number_of_available_kudos -= 1
    giver.save
  end

  def increase_number_of_available_kudos
    giver.number_of_available_kudos += 1
    giver.save
  end
end
