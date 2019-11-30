FactoryBot.define do
  factory :cuisine do
    sequence(:name) { |n| "Exótica#{n}" }
  end
end
