# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


50.times {  User.create!(username: Faker::Name.name, password: "123456") }

users = User.all
50.times do
  user = users.sample
  user.goals.create!(body: Faker::Company.bs, sharing: ["Public", "Private"].sample)
end
