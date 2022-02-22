# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
DatabaseCleaner.clean_with(:truncation)

users = []
puts "Users incrementation"
10.times do |x|
  user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.words, email: "mail#{x}@yopmail.com", encrypted_password: "test")
  users << user
end

events = []
puts "Events incrementation"
10.times do |x|
  event = Event.create(start_date: Faker::Date.forward(days:5), duration: 60, title: Faker::Movies::StarWars.character, description: Faker::Quote.yoda, price: Faker::Number.between(from: 30, to: 100), location: Faker::Nation.capital_city, admin_id: users[rand(0..9)].id)
  events << event
end

attendances = []
puts "Attendances incrementation"
10.times do |x|
  attendance = Attendance.create(stripe_customer_id: [rand(0..9)], participant_id: users[rand(0..9)].id, event_id: events[rand(0..9)].id)
  attendances << attendance
end
