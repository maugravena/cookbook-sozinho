FactoryBot.define do
  factory :recipe do 
    recipe_photo { Rack::Test::UploadedFile.new("#{::Rails.root}/spec/support/recipe1.jpg", 'image/png') }
    title { Faker::Food.dish }
    difficulty { ['Easy', 'Medium', 'Hard'].sample }
    cook_time { rand(10...40) }
    ingredients { Faker::Lorem.words(number: rand(3..6)).join(', ') }
    cook_method { Faker::Lorem.sentence(word_count: rand(5..12)) }
    recipe_type
    cuisine
    user
  end
end
