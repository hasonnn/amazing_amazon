# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all

200.times do
    created_at = Faker::Date.backward(days:365 * 5)

    Product.create(
        title: Faker::WorldCup.city,
        description: Faker::ChuckNorris.fact,
        price: rand(100_000)
    )
end

items = Product.all

puts "Generated #{items.count} items"