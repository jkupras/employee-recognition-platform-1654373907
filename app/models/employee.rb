class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :giver_kudos, class_name: 'Kudos',
                         foreign_key: 'giver_id'
  has_many :receiver_kudos, class_name: 'Kudos',
                            foreign_key: 'receiver_id'
end
