FactoryBot.define do
  factory :employee do
    sequence :email do |n|
      "employee#{n}@factory.com"
    end
    password { 'password' }
  end
end
