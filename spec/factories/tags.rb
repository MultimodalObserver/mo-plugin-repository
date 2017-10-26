FactoryGirl.define do
  factory :tag do

    sequence :name { |n| "name#{n}" }
    sequence :short_name { |n| "short-name#{n}" }

  end
end
