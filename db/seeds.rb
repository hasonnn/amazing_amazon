# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Like.destroy_all
# Tagging.destroy_all
# Tag.destroy_all
User.destroy_all
Review.destroy_all
Product.destroy_all

PASSWORD = 'supersecret'
super_user = User.create(
  first_name: "Jon",
  last_name: "Snow",
  email: "js@winterfell.gov",
  password: PASSWORD,
  is_admin: true
)
10.times do 
  first_name= Faker:: Name.first_name
  last_name= Faker::Name.last_name
  User.create(
  first_name: first_name,
  last_name: last_name,
  email: "#{first_name}.#{last_name}@example.com",
  password: PASSWORD
  )
end
users = User.all

# NUM_TAGS = 20
# NUM_TAGS.times do
#   Tag.create(
#     name: Faker::ElectricalComponents.active
#   )
# end
# tags = Tag.all

100.times do
  created_at = Faker::Date.backward(days:365 * 5)
  p = Product.create(
    title: Faker::Book.genre,
    description: Faker::Device.platform,
    price: rand(100_000),
    created_at: created_at,
    updated_at: created_at, 
    user: users.sample
  )
  if p.persisted?
    p.reviews = rand(0..10).times.map do
      Review.new(body: Faker::GreekPhilosophers.quote, rating: rand(1..5), user: users.sample)
    end
  end
#   p.tags = tags.shuffle.slice(0, rand(tags.count))
end
products = Product.all 
reviews = Review.all
puts Cowsay.say("Generated #{products.count} products", :sheep)
puts Cowsay.say("Generated #{reviews.count} reviews", :dragon)
puts Cowsay.say("Generated #{users.count} users", :ghostbusters)
puts Cowsay.say("Login with #{super_user.email} and password: #{PASSWORD}", :koala)
# puts Cowsay.say("Generated #{Tag.count} tags", :bunny)