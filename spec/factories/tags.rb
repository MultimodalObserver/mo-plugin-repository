FactoryGirl.define do
  factory :tag do
    
    sequence :short_name { |n| "short-name#{n}" }

  end
end
