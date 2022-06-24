FactoryBot.define do
  factory :company_value do
    sequence :title do |n|
      "Company Value Title#{n}"
    end
  end
end
