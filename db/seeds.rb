# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
User.create!([
  { email: 'user@email.com', password: '123123' },
  { email: 'user_other@email.com', password: '123123' },
  { email: 'admin@email.com', password: '123123', admin: true }
])

recipe_types = RecipeType.create!([{ name: 'Salgada' }, { name: 'Doce' }])
cuisines = Cuisine.create!([{ name: 'Brasileira' }, { name: 'Japonesa' }])
levels = ['Easy', 'Medium', 'Hard']

12.times do |i|
  r = Recipe.create!(
    title: Faker::Food.dish,
    difficulty: levels.sample,
    cook_time: rand(10...40),
    ingredients: Faker::Lorem.words(number: rand(3..6)).join(', '),
    cook_method: Faker::Lorem.sentence(word_count: rand(5..12)),
    recipe_type_id: recipe_types.sample.id,
    cuisine_id: cuisines.sample.id,
    user_id: 1,
    status: [:pending, :approved].sample
  )
  r.recipe_photo.attach(
    io: File.open(
      "#{::Rails.root}/public/assets/images/recipe#{i}.jpg"
    ), 
    filename: "recipe#{i}.jpg", content_type: 'image/jpg'
  )
end

12.times do |i=12|
  r = Recipe.create!(
    title: Faker::Food.dish,
    difficulty: levels.sample,
    cook_time: rand(10...40),
    ingredients: Faker::Lorem.words(number: rand(3..6)).join(', '),
    cook_method: Faker::Lorem.words(number: 10).join(' '),
    recipe_type_id: recipe_types.sample.id,
    cuisine_id: cuisines.sample.id,
    user_id: 2,
    status: [:pending, :approved].sample
  )
  r.recipe_photo.attach(
    io: File.open(
      "#{::Rails.root}/public/assets/images/recipe#{i}.jpg"
    ), 
    filename: "recipe#{i}.jpg", content_type: 'image/jpg'
  )
end
