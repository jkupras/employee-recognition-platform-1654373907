FactoryBot.define do
  factory :kudo do
    title { Faker::Beer.brand }
    content { Faker::Lorem.sentences(number: 1) }
    giver factory: :employee
    receiver factory: :employee
    company_value
  end
end
