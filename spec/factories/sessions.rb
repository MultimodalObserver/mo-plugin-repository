FactoryGirl.define do

  factory :current_user1, class: User do
    id 3
    email "felipe.xxx@mail.jp"
    password  "123456789"
    password_confirmation  "123456789"
  end

end
