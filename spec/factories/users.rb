FactoryBot.define do
  factory :user do
    email { 'user@email.com' }
    password { '123456' }
  end

  factory :other_user, class: User do
    email { 'other_user@email.com' }
    password { '123456' }
  end
end
