FactoryGirl.define do
  factory :user do

    sequence :email { |n| "felipe#{n}@mail.jp" }

    password  "123456789"
    password_confirmation  "123456789"

    trait :normal_user do
      role :normal_user
    end

    trait :moderator do
      role :moderator
    end

    trait :admin do
      role :admin
    end

    trait :active do
      status :active
    end

    trait :banned do
      status :banned
    end

  end
end
