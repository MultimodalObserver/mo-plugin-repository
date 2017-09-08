FactoryGirl.define do
  factory :user do

    sequence :email { |n| "felipe#{n}@mail.jp" }

    password  "123456789"
    password_confirmation  "123456789"

    trait :normal_user { role :normal_user }
    trait :moderator { role :moderator }
    trait :admin { role :admin }

    trait :active { status :active }
    trait :banned { status :banned }
  end
end
