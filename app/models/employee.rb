class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validate :number_of_available_kudos_cannot_be_less_then_zero

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :giver_kudos, class_name: 'Kudo',
                         foreign_key: 'giver_id',
                         dependent: :destroy,
                         inverse_of: :giver
  has_many :receiver_kudos, class_name: 'Kudo',
                            foreign_key: 'receiver_id',
                            dependent: :destroy,
                            inverse_of: :receiver
  has_many :orders, dependent: :destroy

  def number_of_available_kudos_cannot_be_less_then_zero
    return unless number_of_available_kudos.negative?

    errors.add(:number_of_available_kudos, 'there are no available kudos to give')
  end

  def reduce_number_of_available_kudos
    self.number_of_available_kudos -= 1
    save!
  end

  def increase_number_of_available_kudos
    self.number_of_available_kudos += 1
    save!
  end

  def reduce_number_of_available_points
    self.available_points -= 1
    save!
  end

  def increase_number_of_available_points
    self.available_points += 1
    save!
  end
end
