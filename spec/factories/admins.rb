FactoryBot.define do
  factory :admin do
    sequence :email do |n|
      "admin#{n}@factory.com"
    end
    password { 'password' }
  end
end
