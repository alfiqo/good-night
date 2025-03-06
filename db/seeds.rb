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

1000.times do
  User.create!(name: Faker::Name.name)
end

puts "✅ Seeded #{User.count} users!"

users = User.all.sample(1000)
users.each do |user|
  slept_at = Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  woke_at = Faker::Time.between(from: slept_at, to: DateTime.now)
  duration_minutes = ((woke_at - slept_at) / 60).to_i
  SleepRecord.create!(slept_at: slept_at, woke_at: woke_at, duration_minutes: duration_minutes, user: user)
end

puts "✅ Seeded #{SleepRecord.count} sleep records!"

follower = User.all.sample
followed_users = User.where.not(id: follower.id).sample(1000)

followed_users.each do |followed|
  Following.create!(followed: followed, follower: follower)
end
puts "✅ Seeded #{Following.count} followings!"
