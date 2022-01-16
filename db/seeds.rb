# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "destroying database"
Like.destroy_all
Article.destroy_all
User.destroy_all
puts "database destroyed"
users = []
users << User.create!(
  user_name: "babin",
  email: "babin123@gmail.com",
  password: "1234",
  password_confirmation: "1234"
)
users << User.create!(
  user_name: "bohora",
  email: "bohora123@gmail.com",
  password: "1234",
  password_confirmation: "1234"
)
users << User.create!(
  user_name: "alpha",
  email: "alpha123@gmail.com",
  password: "1234",
  password_confirmation: "1234"
)
users << User.create!(
  user_name: "beta",
  email: "beta123@gmail.com",
  password: "1234",
  password_confirmation: "1234"
)
puts User.count
articles = []
12.times do
  articles << Article.create!(
    title: Faker::Movie.title,
    content: Faker::Lorem.paragraph_by_chars,
    user: users.sample
  )
end
puts Article.count

30.times do
  like = Like.new(
    user: users.sample,
    article: articles.sample
  )
  like.save if like.valid?
end
puts Like.count

puts "seeding done!!"

