# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
User.create(email: Faker::Internet.email, password: '123123')
RecipeType.create(name: 'Salgada')
Cuisine.create(name: 'Brasileira')

25.times do
  Recipe.create(
    title: Faker::Food.dish,
    difficulty: 'Easy',
    cook_time: rand(10...40),
    ingredients: Faker::Food.ingredient,
    cook_method: Faker::Lorem.words(number: 10).join(' '),
    recipe_type_id: 1,
    cuisine_id: 1,
    user_id: 1
  )
end
