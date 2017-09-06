FactoryGirl.define do

  # Valid

  factory :user1, class: User do
    id 1
    email "felipe.xxx@mail.jp"
    password  "123456789"
    password_confirmation  "123456789"
  end

  factory :user2, class: User do
    id 2
    email "   nOrMaL@mail.jp    "
    password  "123456789"
    password_confirmation  "123456789"
    role :normal_user
    status :deleted
  end

  factory :user3, class: User do
    id 3
    email "mOd@mail.jp    "
    password  "123456789"
    password_confirmation  "123456789"
    role :moderator
    status :banned
  end

  factory :user4, class: User do
    id 4
    email "aDmI!#$%&'*+-/=?^_`{|}~n@mail.jp"
    password  "123456789"
    password_confirmation  "123456789"
    role :admin
    status :active
  end


  # invalid

  factory :user1_invalid, class: User do
    id 5
    email "aDmIn_invalid@mail.jp"
    password  "123456789"
    password_confirmation  "123456789"
    role 3
  end

  factory :user2_invalid, class: User do
    id 6
    email "aDmIn_invalid@mail.jp"
    password  "123456789"
    password_confirmation  "123456789"
    role :admin
    status 3
  end

  factory :user3_invalid, class: User do
    id 7
    email "aDmIn_invalid@mail.jp"
    password  "1234567890"
    password_confirmation  "123456789"
    role :admin
  end

  factory :user4_invalid, class: User do
    id 8
    email "aDmIn_inval@ma@il.jp"
    password  "123456789"
    password_confirmation  "123456789"
    role :admin
  end

  factory :user5_invalid, class: User do
    id 9
    email ""
    password  "123456789"
    password_confirmation  "123456789"
    role :admin
  end




end
