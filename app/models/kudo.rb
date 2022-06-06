class Kudo < ApplicationRecord
  belongs_to :giver_id, class_name: 'Employee'
  belongs_to :receiver_id, class_name: 'Employee'
end
