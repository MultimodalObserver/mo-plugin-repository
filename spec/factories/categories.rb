FactoryGirl.define do
  factory :category do

    sequence :name { |n| "name#{n}" }
    sequence :short_name { |n| "short-name#{n}" }

  end
end
