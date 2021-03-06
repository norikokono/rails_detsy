# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


NUM_OF_USERS = 20
NUM_OF_PRODUCTS = 30
NUM_OF_REVIEWS = 3

PASSWORD = 'supersecret'

Like.destroy_all()
Review.destroy_all()
Product.destroy_all()
User.destroy_all()

super_user = User.create(
  first_name: 'jon',
  last_name: 'snow',
  email: 'js@winterfell.gov',
  password: PASSWORD
)

NUM_OF_USERS.times do |x|
  u = User.create({
    first_name: Faker::Games::SuperSmashBros.fighter,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: PASSWORD
  })
end

users = User.all


NUM_OF_PRODUCTS.times do |x|
  created_at = Faker::Date.backward(days: 365)
  product = Product.create({
    title: "#{Faker::Cannabis.strain}-#{rand(1_000_000_000)}",
    description: Faker::Hipster.paragraph(sentence_count: 2, supplemental: true),
    image: Faker::LoremFlickr.image(search_terms: ['vase'], match_all: true),
    price: rand(100_000),
    user: users.sample,
    created_at: created_at,
    updated_at: created_at
  })

  
NUM_OF_REVIEWS.times do
  r = Review.create({
      rating: rand(1..5),
      body: Faker::Hacker.say_something_smart,
      product: product,
      user: users.sample
    })
    if r.valid? 
      rand(0..10).to_i.times.each do 
        Like.create(
          user: users.sample,
          review: r
        )
      end
    end
  end
end

products = Product.all
reviews = Review.all
likes = Like.all

puts Cowsay.say("Generated #{products.count} products with #{NUM_OF_REVIEWS} reviews each!", :sheep)
puts Cowsay.say("Generated #{users.count}  users!", :turtle)
puts Cowsay.say("Generated #{likes.count}  likes!", :bunny)

