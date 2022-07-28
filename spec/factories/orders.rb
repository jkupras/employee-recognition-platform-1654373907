FactoryBot.define do
  factory :order do
    employee factory: :employee
    reward factory: :reward
    amount { 1.11 }
  end
end
