FactoryBot.define do
  factory :recipe_type do
    sequence(:name) { |n| "Caseira#{n}" }
  end
end
