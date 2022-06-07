class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :giver_kudos, class_name: 'Kudo',
                         foreign_key: 'giver_id',
                         dependent: :destroy,
                         inverse_of: :employee
  has_many :receiver_kudos, class_name: 'Kudo',
                            foreign_key: 'receiver_id',
                            dependent: :destroy,
                            inverse_of: :employee
end
