# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Clear existing users
User.destroy_all
SleepRecord.destroy_all

100.times do
  User.create!(name: Faker::Name.name)
end

puts "✅ Seeded #{User.count} users!"

100.times do
  user = User.all.sample
  SleepRecord.create!(slept_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now), user: user)
end

puts "✅ Seeded #{SleepRecord.count} sleep records!"

100.times do
  follower = User.all.sample
  followed = User.where.not(id: follower.id).sample
  Following.create!(followed: followed, follower: follower)
end
puts "✅ Seeded #{Following.count} followings!"
