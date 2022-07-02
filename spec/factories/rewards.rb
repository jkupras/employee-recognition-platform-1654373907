FactoryBot.define do
  factory :reward do
    sequence :title do |n|
      "book#{n}"
    end
    sequence :description do |n|
      "description for book number #{n}"
    end
    sequence :price do |n|
      n + 1.99
    end
  end
end
