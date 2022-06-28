# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
1.upto(5) { |i| Employee.create!(email: "test#{i}@test.com", password: 'password') }

%w[Honesty Ownership Accountability Passion].each do |title|
  CompanyValue.create!(title: title)
end

5.times do
  Kudo.create!(title: Faker::Beer.brand,
               content: Faker::Lorem.sentences(number: 1),
               giver_id: Employee.first.id,
               receiver_id: Employee.last.id,
               company_value_id: CompanyValue.last.id)

  Reward.create!(title: Faker::Food.fruits,
                 description: Faker::Lorem.sentences(number: 1),
                 price: Faker::Commerce.price(range: 1..10.0))
end

Admin.create!(email: 'admin@admin.com', password: 'password')
